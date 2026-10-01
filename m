Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE89CA5FD6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 17:54:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCKxx-00086i-57; Thu, 01 Oct 2026 13:53:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxl-00084M-Qg
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCKxi-0001rl-6x
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 13:52:57 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FsU504062347
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 17:52:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tLV/1pN4v1/wFufEmC44bR6T3B/o/NPZnuWcwod3zAM=; b=mSPIJyPJ9lbgNQOl
 MM/ltpiF3zJGbxxIVUs8Na4HUO9DMvuXu89jwTJBpxvbz2CbLgbumbfBKKZs7sTK
 qGgx1UyOLNnXSmz0Sy6jKFhQ2dsByUhebqKDlTwg8u/qn/q3aVKfpW/SG4DwwKMG
 VCVIh6/KuBg3AFvhLG0rFFrh/7uYW9SLfiye+jtj4z+IzYYZdfbEoLLgFJssYphR
 n41vJteNH/hS47iqz4nM7O/bbuO94o/8ylwJyS0wqiNlEAez/s6jaDvvPuxYZ79X
 CcxrZ8+tpfzFK63HzUQbMiAtR8c1WZMAzRXQVnWTGEgSldNb8e9NY29RLsE/28ZK
 okIqKA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1p2b9vht-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:52:52 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-34d62bb27a1so5881580eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790877171; x=1791481971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tLV/1pN4v1/wFufEmC44bR6T3B/o/NPZnuWcwod3zAM=;
 b=NUgN76rKkActXuTUF7w99lw0pikMj98Df/YjUlbnZznzZGDawKGtJ0KSvu5IX78uVz
 EJbt3AjAfdzfcHQHC/s3Tho4O0Z3Km7osvrK5SleKV3prSjPbCZjZbVpruzpzCWQ4jEX
 ndq/GDH5LhL4vKK2krhbbFdgFdODaZDOt9fiQDzRZL+70+sl/YV7a54ZB51lrweXjfcO
 vjMy0H+pTaRSyEmAz6Wt4YaL/k+3+sOwpX+dzGdweHFidXS1Ji7FvPfp/1GjT2qymVAH
 8Z4PiNjgVPvxRYEFUnsP/LlCZVvYbe0vtfDLQ4d4uu6Ab0+FL1xdjFLA/ac0nbDX+LzP
 FyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790877171; x=1791481971;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tLV/1pN4v1/wFufEmC44bR6T3B/o/NPZnuWcwod3zAM=;
 b=J0GSYoKNRCWuvo6zCfIYedMn74H2l1x5MWYBs0J8nBO+B9UgfX068/GiVCO4odsbJh
 x99F4uTJNsxB8dz50tjysTjgSinFmA75t86jMZugBALtcpR2tP3BWsspr6Ly8LnpdY1y
 +47QNsGSTCUyP577NNec/PNdQDSZaHzsYPRA48F9XzkQ8ozUSP9Pz8kxqsr0A2pq5jB/
 f0wzLF3yPDU+gWTS6EfCu3368EhVWPfmHMEgAfr9diu7iPgUxwibVSCgBN5WzZYan6e8
 zF5xWwvq6DhL6xduAAUxn39C94CmczhefYBp0kxdo9x3X55N9zVBjy87B3ejUUe8zAgL
 gfmQ==
X-Gm-Message-State: AFuF++nT8hyLus5U8Ya75HGq2pm8BABL1vs7vzW7C9zkZtEe9NxZxprj
 02E/Dg7TxrhXoGa5Ynt3EP+AN4ckTJvmQNF2mzr/ZcqXPPSxHzdsNXkEidE8qsi2TVSTxthupl2
 eHeAeF3IL6MWinV6tq9gGa2u+3wwzpvpw/GpmPiB5frf40l7NXzaTOynvE6asQNHfJw==
X-Gm-Gg: AYBFou3ljy2YAES4XXksJqzUmRvHtlZsKHZ3uo9O+hZm2RP/BVeh59ZePB2fbjxzFUh
 hk5HJ4bL4Z/76ZdZm40c78sHmJx+N1y9nXUzUeSUwQ8QE6MpeFhxY7WA1mx33nEbmE0qBnruFSt
 oPTPa/gLKPaItTpaFjT6judVak9DXhrImTi6MMC5swTWWWQvJ6w6i6IsLPpQryULBzvLJhYv3a0
 AUHm4Xzxg2vfz+5z58d9Z/hd3+S16FzJW8dZvrXzG+BcNKsuayski8R8f6Azdu7GU2I46EM4Kgm
 0dzNsvZ8aUC3t9wNSEIFksMcOpPVtqS31Pw5ToEiSnyM1jc6Lf/FKS7bBtNWTlRFAdV0OcbTSMv
 NG+ka6YpbtbW1Bc+MF3PBN3jVrSaBFxsiIEirAZkrsSaL7hfGgDCqF1SyZpM3
X-Received: by 2002:a05:7022:7f03:b0:143:298e:45a1 with SMTP id
 a92af1059eb24-14d33490547mr5608172c88.40.1790877171241; 
 Thu, 01 Oct 2026 10:52:51 -0700 (PDT)
X-Received: by 2002:a05:7022:7f03:b0:143:298e:45a1 with SMTP id
 a92af1059eb24-14d33490547mr5608093c88.40.1790877169598; 
 Thu, 01 Oct 2026 10:52:49 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f43fb3417sm207518c88.1.2026.10.01.10.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 10:52:49 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 25/27] tests/tcg/multiarch: add missing vma-pthread test
Date: Thu,  1 Oct 2026 17:52:01 +0000
Message-ID: <20261001175203.8673-26-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001175203.8673-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9CeCwFE10LFEH30oClVVlhs529V7GDqQ
X-Proofpoint-ORIG-GUID: 9CeCwFE10LFEH30oClVVlhs529V7GDqQ
X-Authority-Analysis: v=2.4 cv=O8SsLx9W c=1 sm=1 tr=0 ts=6abe9df4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=xXatPaY6A71EF1Dc_LYA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX5yodrnM8SCDb
 ojtJ/c5gZ3calrPk1OPjujorG5iokoh/tttoglvFUDP2CkqTalnLSVpJx9OTft7rk/w7sQBSkn5
 kYX3KZn3r9ZU+d08KccPMfmC2qQkRz4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA3MSBTYWx0ZWRfX4/37KEuz+y4u
 x4SyMOkFRPmcGSppeu3loygGsAMvTgbdDC+p5PjxODmAq9/7imz6OeEjxFeM8uISjjHzew7Fcwc
 o+8HRnwy6Ig2eDP45WeTXErC/ROFgQfN1hH3i3NvktNd5gI2ClPlo2kc2pKRMiFCEKAvPKr2agE
 aOxymixL9/zIKPTztGWCDQf7PmyAERsqkxYnC05lHc3g6XR9Mw+cSs147oSJvyW+z5J8wiJ0s59
 EAoulkEoy53apZ3Isl40DW35bewMQmMMRmM3yKNV2muQyFtPzcwq/BcJ87yQGRN9a5XWN38TDG4
 HTSuY3mmVt6WiwCZN7AyEaRwy3vOBflz1UJi+/pQbX/JeeAfECRnpfKQ4KVAjZvttVhtoiaYbFP
 TJbU9heacB5kAsl3h45tmxj90ubSbD2+tx3oE+f2d7aGTgg5eyDGuuUt+MIj6RErCPNuH4QfxOF
 Uk0cI+bFq6mcVGqfABg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010071
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261001163751.172720-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/multiarch/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/multiarch/meson.build b/tests/tcg/multiarch/meson.build
index c3816d3a218..e60a0527007 100644
--- a/tests/tcg/multiarch/meson.build
+++ b/tests/tcg/multiarch/meson.build
@@ -51,6 +51,7 @@ tests += {
   multiarch/'test-xpage-chain.c': {'cflags': ['-lpthread']},
   multiarch/'testthread.c': {'cflags': ['-lpthread']},
   multiarch/'threadcount.c': {'cflags': ['-lpthread']},
+  multiarch/'vma-pthread.c': {'cflags': ['-lpthread']},
 }
 
 # Linux tests
-- 
2.43.0


