Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC27606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SpVMnLeV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gt21Xz8a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0h8-0005R0-Bk; Thu, 22 Oct 2026 17:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0h6-0005Ql-Vn
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xK0h5-0007PL-FO
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:28 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MIHHMn4086715
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ck5CAap5Jh83MDiH0yDS56spWTpkEo042JsEpwD82uQ=; b=SpVMnLeVYA+Hp59p
 uWXrMBeZR3DeGlWeoifScndPYPabg5Z2gt3wJ1oF4aXBJ+vvvq8xRsRnIaLga7WJ
 jYwIP0U850FVmQUBcw6jehDWZvUbHQWgAJjATpHLwhTmKfbrQCGqElWkIwV1bspj
 N77ZRqi7QMRKlAvQta99p8R+3EIjMP4aenRUh20XykVzR/L8VhB4Zj0V+wRfEGqE
 FYRfApMlelCST+oh5H5orfziFHEFqxwqolj6hCFYJjqdCfhHZmwKBbLdYC0Oh3xt
 IxjZE+TFuQTEGREP/oUDs5dnwYYZaraIbFByqGrHEIoDca5fjHnyND2wI8z/P4ts
 rYiYoQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmtrpg2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93dd3c3badbso52840485a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705885; x=1793310685; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ck5CAap5Jh83MDiH0yDS56spWTpkEo042JsEpwD82uQ=;
 b=gt21Xz8afJP2p8P8W9Tp8ixbOYzCdTRvmkEfUICxOoL/QFFSljWWE4ZQB6hJwMTPvc
 NtMqopXvK46/IGdxcfYcvu6zuNrKmSPuO/l9DBfy12P3oSIn5CO+ALM+DN4EUDlpOhng
 lphDoeTC2F1NbBO1KwvEjsKwe09ura5iLidH2I1W/gEoqAVjR90XIwdIpODkqvrQ6YYg
 xlHlo4Pfzx2k2dRpcec7WzX34gfv7iiZ4uTGZ+wXchUXUrzEf6EUZVlGpN7vah+Gwxm+
 uwI8G9JaWf/lS1b5XBo37/dI5VqELdSbayXI1/Gc4duiyB9UZ1Jy+QlXJD6BEBiYZsjq
 jmqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705885; x=1793310685;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ck5CAap5Jh83MDiH0yDS56spWTpkEo042JsEpwD82uQ=;
 b=mmnZ+BQD115+5dub921+ew0akoIxCsZktkFvh1lMBusUPV4hZbIAoQiR0gzzP64LoB
 biJgks5y87wD89dIVfy0H6PkYxagkjH9pqw1ar1+prj1BCKr6kw4ziOxDyZ/Xkl/WHFY
 A5/Tu17fR1lByAvNLZJkxCsXcEiqRiCfTMx1mezWwE49OPfwTePDJttqw7+qSvOWhva4
 LB+HlQJR8tKdfs2n+b+sZ+iZpjCbSPSjfJCH1ulJF61KcnBoGW5OCGOOTK8CxGbbyhea
 6KTrxfM2vsBV3GIz3mzmr4UkEsN8XU31QAcDN7EA+e+1guJKQA4l2SvcHL2Iluix+LQ1
 VS7g==
X-Gm-Message-State: AFq9FYK1HgLEumWKAW0gBNZXDGKxKYFVSyQKqa1f9qqnQR/Ni73rWPrT
 L24H+PtFvUUXayBdOXMZGWfoOepQhL1kvCy4QaAt0mRGOOAuthR7y4goYfrUEtY0fZwqY9e15K/
 OQiaYRc4Nz8ymNXHvAoMB8qBy9qm/250JtdGNObPk51Yw7Q9pM0u/oywbeOqX/OvzUA==
X-Gm-Gg: AYBFou2L//DYnZgWPApv3JKTG3TwsYRK/9A//K6EqDBcfreJKWijbs7Vn7e0lqa1xUP
 Gze87xW7XRLgCZTSj3HIkxwDDyERYhHb+6vn+YUQMfa9sN03XbxmG0BH3Rzuos9WoqJgnuqgIW+
 wu107GwGnz6I4XmS0cavFXNN5/AzjwoiZMIhw0byZeW2YFj3+saubCFiUQYW06cWMEtr3xSteu0
 zqfIGZL66G56jX/fAoHJ0jnP8fD6HtfYf6AolKUkG7UgFxktura9BNT6R/r7xyjETfX9TCFzhtx
 FbJijZbqUXVTzJT/Tmye9Zut3kCxEDoARLaJ0orkbTvhns8dgjCNx7AB9y0zrOUBEyElIjMOFfO
 elv2LNholL5mNNUnfWoS6lOUfaLT/Bd24wsilR6QZ
X-Received: by 2002:a05:620a:1b98:b0:93c:6417:f9c8 with SMTP id
 af79cd13be357-93f6f782e79mr152898085a.29.1792705884715; 
 Thu, 22 Oct 2026 14:51:24 -0700 (PDT)
X-Received: by 2002:a05:620a:1b98:b0:93c:6417:f9c8 with SMTP id
 af79cd13be357-93f6f782e79mr152896785a.29.1792705884291; 
 Thu, 22 Oct 2026 14:51:24 -0700 (PDT)
Received: from localhost.localdomain (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a212374458sm4760585e9.3.2026.10.22.14.51.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Oct 2026 14:51:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 01/33] qemu/osdep: Document ARRAY_SIZE() macro rejects
 pointers
Date: Thu, 22 Oct 2026 23:50:41 +0200
Message-ID: <20261022215115.19680-2-philmd@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022215115.19680-1-philmd@oss.qualcomm.com>
References: <20261022215115.19680-1-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Gt3XaU1C c=1 sm=1 tr=0 ts=6ada855d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=EMdT0scSaJAOcc9uYYYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: tF0Ix-5atlICf_YPnRpJ1MRo-cE6sWht
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX5Ew3ru59tGTu
 lepEY5Hn80CJcG4qWD2TIxtypXLCUfNniYrsC3s+EBoFdPuwP54D+gl3Q/JhZvGJWWQj0VtrZqB
 Sohl+bf+qhgghKpKR5eCem3TFB5suaAUhUNovodNtRlUzK+PLGRa75VH5zbZR8LoJ/jvT2yggXs
 N6Z406jWQU8dbggzXSathgXndZsYZKJtmms0wjgmebFRb0RI2GEVKg5ReRhUlcy19Q83U+hWIh1
 w0+4SsaBlHO5VD0iBnGZ6TXAhFK1fPZGz4I2OuySEd7EeyT2YYtO5yJkFgh0P5Zf7zWl7CXBTKT
 PTZGEU8m7ZjZVF8Kf086/8AfuXjPmYjjLvcBrqmGXUOxNQG3Rur2xivPkmJXaGkxC3kig8ANmqY
 rxlCHeObrkSHXSQIa7yQAJQNaTeIyWSBPF1GncpfM64ISVXqEE/5nwEfB7mnwPP/J7/XC/8z1f5
 0/I/aqFE2IlW63c08kg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX9QNc9nJTdrrp
 7TIXVH6vF1Yf47BRVa89MbDA3T/ZMvaFn607bJp7lPYr2EYHOksXKXcwhNmhHyaWp+/nREW6IRW
 9IDE6ADNi2g7VWxCekdJQBPXn4enWG4=
X-Proofpoint-ORIG-GUID: tF0Ix-5atlICf_YPnRpJ1MRo-cE6sWht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit ed63ec0d22c ("ARRAY_SIZE: check that argument is an
array"), passing a pointer to ARRAY_SIZE() is a build error.
Document that.

Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 include/qemu/osdep.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/qemu/osdep.h b/include/qemu/osdep.h
index 1ec5b42230b..5d5695ade28 100644
--- a/include/qemu/osdep.h
+++ b/include/qemu/osdep.h
@@ -528,6 +528,12 @@ void QEMU_ERROR("code path is reachable")
  */
 #define QEMU_IS_ARRAY(x) (!__builtin_types_compatible_p(typeof(x), \
                                                         typeof(&(x)[0])))
+/**
+ * ARRAY_SIZE() - Return the number of elements of an array
+ * @x: the array
+ *
+ * Note: fails to build if @x is a pointer.
+ */
 #ifndef ARRAY_SIZE
 #define ARRAY_SIZE(x) ((sizeof(x) / sizeof((x)[0])) + \
                        QEMU_BUILD_BUG_ON_ZERO(!QEMU_IS_ARRAY(x)))
-- 
2.55.0


