Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F85DCA5FD4
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:39:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJnN-000576-HG; Thu, 01 Oct 2026 12:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJnL-00056Q-Nk
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJnK-0001z7-2N
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:07 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsiXe3115100
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 16:38:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=bBfceCexOgm
 2/mx37vlkZznUb8WunD/rVA86Iv7sR/A=; b=ZzYVW6h8oB6j45OyoFb72qGI6B6
 0AsMRtc6oftt+BKe/0I5KpQ0HAqXmitmU4mOAZjmF1x8b63bjjhLi+yz6+oxuv4K
 MWIoSLb0rPjl0QTV1n+SPbXf6WT6cMJq9uQnVJIypdtcwVRoc6VpEJS79nWZkGDz
 xxktf1nkHoIe1BvgNZ3uZYZdJVRqn0XBfAsmPXEBu7BI5JpE1Sq2KOW84fHu8et2
 3dw72iWM+tsS6QPQcFM7BHnLMPjEh2OqDI+J1szyLO4r0fFJ5GgmG37NILenwGi9
 UF9rt+VtBAErHE47UPjrYbv5LrIp1MJvQGc9uFB5XUt4YMEiB04Ka+/WWiQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1bh5c21u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:38:04 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso5029872eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790872684; x=1791477484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bBfceCexOgm2/mx37vlkZznUb8WunD/rVA86Iv7sR/A=;
 b=Eekqgl7DByAz4DUojPWkhY9Z1KwvlmKIJkhPbP5y8szlWbvEiBm7iSWUaa/13bVYAr
 VgHvTIsn0NFB5UUg9wX55EWWBT66ALHq0bHDAf4Ij6npSrggZgQMkYcnEZZNRWO8O+0Y
 LxeKNUGqr0DgvgXKkS1i1OdpHZJWgLxfhPzGH5tVRoPJy+F9V+ozqjGdqk91HcBadefY
 Cw9owSWHdl4ExpLFBlIdba7ICH0MWhooPgAjG0OicrSZz+/FrON2q+7jkg6LcEhywqvA
 lXW3G8YngJ5EAQFC743C53Lj+DkTks0XYku8ze12XgEpqRHp7/sSpbxjmYcXUQL+I55p
 Lebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790872684; x=1791477484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bBfceCexOgm2/mx37vlkZznUb8WunD/rVA86Iv7sR/A=;
 b=q41xLuaSv7itMZmrWHg9mc5wGmJOS5t7wq2/u6XgbbeMbRhFfssrh3x/v8HTvx1UcB
 2utJPXMGROXNe+7IvPf+tfAKKksZOpSrq6baqn46iG5a/VRUOTUqQUGQhByFIzLuLisO
 5loiAswwvXSysBTypQfhHdXkYm//1tzV5pONtbAOlvmrQubAOQsYQwEjk/57sSiPaUbd
 46z1U0lJWK9975JMfxJKHAGHRxnOrW/OZjKvnqmmPf2EdWRKdSl8UA0XmSg6VziPeFWX
 mYS4qAn30JX/M7zkp20SgjKV6ylNPVbrODhPXZpq1vGB/k3c+01Pl4ntfB0018XYzIi8
 vSKg==
X-Gm-Message-State: AFuF++nDsE8REtEnNXWakNUA83vyHxax7m0f84IMaIE/bW4KW/nrqrTF
 E0pR2nv5Oh9wfToHE0JUzM1PdeVihscc4peergeDAa+tJCY9qgwR7VNWH3ul1NP7f2Nix3VzIgk
 87XzsImmgh8CPPYgdZXjy8TuYQRfx3RsDBUsAo+WruYHVHG4Snzkn7Z/jT8qB8Mp13A==
X-Gm-Gg: AYBFou1S/ibIYna5cl0UEw4sto31qwqhACpQdVQ3wcdLKXDW5J3wjOSGGFEyTePYAN0
 hEv1eP5PLMgNcSU7Hc35VJ3+VM4iwX2HyjSFOuWwbSfJwWPtWV/i6gus/C64qK/+A5AK5WwYByn
 /198H9+Seg8ib55q8ASf1r2ZYb8hiMEWfNb+ed/6h6acf56u9uOkydSXH+Xcq8LBNrMV0tNM4HD
 jv8GYNXR9yVY5Llvr5ua4zTTiVvoAL+wRP082tZ0JOrLCoxHxSyZtPlkb2kn6AbSvzNlkSzLDbI
 aYwbpluHvtjMaymDoLYdbvDORa1hDvkjjVgMYZLAXUlBcMWhUlSb6YPB5E4rIv32iBBmI9Az+9U
 So1BxYDbNGyF1DPrHFrepl7Dl2PoM9uAOuPqmzdS4+y5Lw5Ne1om/otehFaz/
X-Received: by 2002:a05:701a:ca89:b0:144:e246:a0b2 with SMTP id
 a92af1059eb24-14d33f395bcmr5517955c88.44.1790872683915; 
 Thu, 01 Oct 2026 09:38:03 -0700 (PDT)
X-Received: by 2002:a05:701a:ca89:b0:144:e246:a0b2 with SMTP id
 a92af1059eb24-14d33f395bcmr5517904c88.44.1790872682985; 
 Thu, 01 Oct 2026 09:38:02 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f26bb14cbsm389846c88.7.2026.10.01.09.38.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 09:38:02 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Dominic P <gcc@gcc.dp11.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/3] tests/tcg/i386: Build test-i386-opt-shr
Date: Thu,  1 Oct 2026 16:37:50 +0000
Message-ID: <20261001163751.172720-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: iPwHgFsGrboO6ctDez2VRWkFeFhZqdUO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX2nbfJz133Uq6
 dhBWmzDS4z+89BOGo5YmbyEsvPtUStGECRqi0Jg7Nsw56y4rQRKZceW0CJLeGL6OFajt+jGCxtF
 5eXfDKtIynxvuDILodM1rXSSz8lMCdk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX4eLlijkA5/8c
 SKEfYZdrJ6ykanlxYLZEbEiu+griMNoGlciaP4RhaVmFTI4CWgd7viISk0V1gsRDRk7txWpOZrY
 V/Uc8gJAYVuJ/pVSWjbhHgY+YtC/SZWWx7bIElBtqtwmmSHr484yRY5wmGlM1QIpReYLeSLaGWR
 ANINoQZWBVcDsjcQdmbrBHQ9XcA1MBuL/0OzdSRH18Axx56D0ozwXSkCQoXOC0uvzMXuzqcb/9b
 4OaMj13PDiBwewc2EJsdWdiwpsbS8zkiCtirBSC3abgamcSEOt7Tl1yq8yY7cQChWHdfQ2sn2hD
 EZKNnmRCRbShRFbJuO+OikVlAVfs0Qej056VSiyrr44XyR1i3VUylI+oc8tZvEJ+pXKARRTzlgN
 Klke3s2EdVpUfqtuQ414hMx1LZbHOGZSxH4+x3LGv9c/0nwxdVFRy5WTqvVcKUqthOqLcIURCsj
 E9SSWQpeAHIDeEBJ72w==
X-Authority-Analysis: v=2.4 cv=NuxE4MdJ c=1 sm=1 tr=0 ts=6abe8c6c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=MDWQuqTfXK60o2R1z3kA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: iPwHgFsGrboO6ctDez2VRWkFeFhZqdUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010066
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Dominic P <gcc@gcc.dp11.uk>

The old Makefile.target built every tests/tcg/i386/*.c.  The meson
conversion lists the tests explicitly and missed test-i386-opt-shr.c,
which 5fe51606146 had added in the meantime, so it is no longer built.

Fixes: b4e3e90d61 ("tests/tcg/i386: user tests")
Signed-off-by: Dominic P <gcc@gcc.dp11.uk>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/i386/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/i386/meson.build b/tests/tcg/i386/meson.build
index 04d438a062a..38723d7f8df 100644
--- a/tests/tcg/i386/meson.build
+++ b/tests/tcg/i386/meson.build
@@ -28,6 +28,7 @@ tests += {
   'test-i386-fxtract.c': {},
   'test-i386-fyl2x.c': {},
   'test-i386-fyl2xp1.c': {},
+  'test-i386-opt-shr.c': {},
   'test-i386-pcmpistri.c': {'cflags': ['-msse4.2']},
   'test-i386-pseudo-denormal.c': {},
   'test-i386-snan-convert.c': {},
-- 
2.43.0


