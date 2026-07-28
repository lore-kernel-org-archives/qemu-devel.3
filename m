Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF0EC54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 04:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woZnu-0005sB-8a; Tue, 28 Jul 2026 00:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZnl-0005gw-7D
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1woZnj-0002Vm-Rt
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 00:52:24 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S3amSN1423504
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JN+OdpeHcMmltGI116CNSMKbTGMPNAS7mvZhZp5Oq/U=; b=Bp+xWPKng+VIsAsC
 aqE3jMBZgz3OiqqoSxm0OqiJp2koEXJd1Gzndx0ZZAYgaGYF3rPCymhDcch3WGI0
 966H44nCQKmz2KtmSrtWagKYKkqW2sWa+V833bdz0RxIq4LfWawyt5LZovZpPXAX
 mjWTA6nnQB1PDrXRAqtT05iXprpfGFVJBs6qFE5qLGQEF1NHCGApIy8iVkRrN47E
 7C589SUNo/cMSNo5NO7kup3+3DeznjFWguzSkod6M7SLR3kHVno6gSdI3STEsUsO
 YU9bntg4+yay5oQnItn3Myyy36NsMd7VsqXfSlx+cNfM9mAv7xjX7yRhzr1AAlHh
 3poU+w==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fp3v2mqa4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 04:52:22 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38e475f83a2so5734350a91.1
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 21:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785214341; x=1785819141; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=JN+OdpeHcMmltGI116CNSMKbTGMPNAS7mvZhZp5Oq/U=;
 b=E22IRbjymMmEvlW9xlauiEMS+QOA5Ldt7boJbn7AbMw26dr+Q+Eg52LI8nfCMQWw89
 kolaFzIxbwKXwbTw8cpTBFbG503bnMSNL9dr2e0Ml0qBVE7+Q7Hq43VHYpcgBxyE8r/w
 r+Q9GnW6MGNIa9X4rjHFSnOzaVFC+xg1FGTes3Ad+arCYX9DrDWZWErEzWAUGajIgPCr
 TeOPaiCXKFC+C9nIwWnFwFe0QAsfRhFVQ5PnZhLZg35erqBkBVQm/jUu8q7eIHscMmST
 WZJ1MGxTBQIww5QMIh88VdtklT/BZLHmng8DNwIXZRY3adD3lyyrh5wXjWDy6LgcuAAE
 i+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785214341; x=1785819141;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JN+OdpeHcMmltGI116CNSMKbTGMPNAS7mvZhZp5Oq/U=;
 b=Ag/DrKtm9wlXwssaDr52R7AmFtk3lJ6xZou9LtAVLH82yjzrwVtvj4P4PMMDD7sblh
 BYFC1iPlVkWpEf0wmUjuvGRCx8pF736P4B6awVliYuhh7zkBQqTrAi70UEqr6+iTbovE
 Sdq7zWIWW12/cF6Ze38O67NmCJ0g//ZtBUQJsHXPeU8HkRWV96RiAYKnvUoISSUIwRxg
 +QB4QuFowIEQSGlW2HtrPFpVCvxHYgOz1v5MqbrWTvUP5mUDUiYxX76ETV7E42nUm0s9
 bd8iqFvUDxyCx1xVpUb3GC/ewbMlno2HMx3lwgOhgVsvoNHiSoS8VFASkoaYTcFBUo2E
 08WQ==
X-Gm-Message-State: AOJu0YxdoIJaRmIJE6k7p+s7OZUl3o8841z5xkqNqUfrYMk7EiQZds2T
 aIbEv+i0lX6SN+L+ZaJIvCLafxoIxkUxwNpTzdRtnXcxP6AG6gcDedFlRnxev311cdeamWkDDEo
 PDwflJjPODBzcLThvuGfZiD0D7ccXweef37MZN9tPYVo6AIOPE34Gv14S9tSN610DnQ==
X-Gm-Gg: AR+sD12z1l8ZGW0dR4FLtuFzGIld3snn5EFUZEcheBc3tmEzQAb6C/9iTAjFkW3BN4T
 wcLzk9frh4haWOuhExexutTY/7EzbBXWDFc5ifyq6+/7Oos61zRsjdacjikdvX7tkFJdkPgb23T
 nAoAGppLXKEXIXFFXFQG6u3KFX9pg6/aXM9YkgDSZRIgPlGkgyowFGpnn7Fl9hznHC92tGnpsUv
 lvR9FFdx8jgWj/fFhhh+fd51auCYrslgl4aQBf31rnsOPYkrpApj9LK11j19+pk6eDxN36cKK54
 Azyar6OAH2dkxFlaLt0LY5wcsx1OT6zjiiQi8SCEU+KKOryyD6JzOWuZX76wHz9M5tSPUCfbyMg
 +SefqVSBjlC8uo19D3j9LissRYM0usdUpqn+uMU70j8Ze5cfPt/jCByGmKNFhIaczsPTgL0M=
X-Received: by 2002:a17:90b:4ad0:b0:38e:8050:e63a with SMTP id
 98e67ed59e1d1-38f6a30cf17mr811970a91.6.1785214341164; 
 Mon, 27 Jul 2026 21:52:21 -0700 (PDT)
X-Received: by 2002:a17:90b:4ad0:b0:38e:8050:e63a with SMTP id
 98e67ed59e1d1-38f6a30cf17mr811939a91.6.1785214340745; 
 Mon, 27 Jul 2026 21:52:20 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-314bc3e878esm38900559eec.3.2026.07.27.21.52.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 21:52:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 081/103] tests/tcg/s390x/head64.S: declare _exit symbol
 after main
Date: Mon, 27 Jul 2026 21:42:25 -0700
Message-ID: <20260728044248.137626-82-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260728044248.137626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX9/m7nXk/B8XE
 mzhDkWjMAiBmj8617F6u5K4X+HkFHFj4NUdshO7v1OyT5tVn3+cjKeQWiy0SgdwsD0k6Ewo55jM
 Mvw1beb+0RZ7WLTswM5XLbKa9SpQc7M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA0MiBTYWx0ZWRfX1pq2nRtF9IRq
 HFbZRP2wCPF2AnaG9L9Ky/tXzlC7bjrsFYdKZcj6fnDJjhSrna1nMqXQsWHFJEGwVXJl8ydB4Fy
 Aaup6n2XzNMTZcGe1pDL2RnkAcnKViKGcsOKRSL+Floi0bo/UsN8IX0iuWgfcp7IiHi+NTGFqEi
 gasR5qkmtpkmVOEXC7yjQV/W7BAhSMx0FaK7t8Y6BIm5+52Iov11ZlMr1tMkwUz9wal1Eqg5zUt
 CwvOCNatLaEgDiSzpgKWEs9QAcsPQ81ufziHtAMdQdiAjVBcRkHv2eLfOmw9XUuI03w3zOocJPG
 7W6lma2DD/JKeyNGdi92BVhwjSsRHtYe+wB+ICgU+OAIeuQjIYja/YhyzfpqHbkx3iKXuIp20Bw
 gNvc3R5e7At//nzh9PrAJenIU+I7NdL2/OzC5q7oF8LnioCMZEhDLOAsXkDURYrnulijHlP4EJG
 N/5L0+F1MpMwONDCokw==
X-Proofpoint-GUID: JRYhgu7LmgS5wu5UQysHGPcu1eljtHpS
X-Authority-Analysis: v=2.4 cv=KJ9qylFo c=1 sm=1 tr=0 ts=6a683586 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=27jwiZK16oKz2i4YsWoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: JRYhgu7LmgS5wu5UQysHGPcu1eljtHpS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_01,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280042
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

tests/tcg/multiarch/gdbstub/registers.py expects to find this symbol to
compare state of registers before and after execution. Define it
explicitly.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/s390x/head64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/tcg/s390x/head64.S b/tests/tcg/s390x/head64.S
index 4fe288388ab..0523fcacb33 100644
--- a/tests/tcg/s390x/head64.S
+++ b/tests/tcg/s390x/head64.S
@@ -14,6 +14,8 @@ main_pre:
     aghi %r15,-160                     /* reserve stack for C code */
     brasl %r14,sclp_setup
     brasl %r14,main
+.global _exit
+_exit:
     larl %r1,success_psw               /* check main() return code */
     ltgr %r2,%r2
     je 0f
-- 
2.47.3


