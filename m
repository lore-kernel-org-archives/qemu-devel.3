Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6FB606A319
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Klq/tr7W;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kq7sjndH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIr7u-0001Kd-Aq; Mon, 19 Oct 2026 13:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr7s-0001KN-0c
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIr7p-0000P0-V7
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 13:26:19 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JFOtCP2268952
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2hxDtN+wsubeZBUd54UCnU0Jho0DVSwQCsLM3NWAX+A=; b=Klq/tr7WYyJFgz6P
 LvWAU62169c1qu1cn8DG9oAl9FY+qgjLnzBLxNlpx6kpt42zaGsmXlwrPIz2SDMJ
 YQAhdgssDyxMh0Jd/cPmYEoVKTuydwMUGY6e6HhJVaDNlSrvX+YMphsLvJfY7Ldl
 TUDjcW5O0U4DI6VeE5fJE7ErrCzt+2CWR5D3Yrd4cyWxPjhggZZfnPucWKh75QZS
 NqUGgmR5Fv5DywdmdIwvBbVp3uZ/TyevDVfY7qrMrbbvFAlJafWA3qzSXWtmhX8T
 /GROCuvpPX9ZN874DK657lwFqOjduYDtvBWfKTO9zunzA6gssOYMSxu3ykgJIRcD
 152MXA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf4rjdkt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 17:26:16 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-35c3c370b17so4730612eec.0
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 10:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792430776; x=1793035576; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2hxDtN+wsubeZBUd54UCnU0Jho0DVSwQCsLM3NWAX+A=;
 b=kq7sjndHABeUeVTPNXged+EuTHrFDBTOShHIgbdrO3VZcEvkG3kvkIcFCEe/Eff5jG
 FG9qFIetcgfiJ6481Wc6PneMHFz3jRPnfqvz7J9vJqc8MkV7lZXAIm3ZJnXx3mpYjrlA
 kNZER7NBU63vGqTP6jC2BYdGSdbYxIaSwX9XRUkr9qNxP9izTDpsQGSDLZmCo/i7KNAm
 mb9b0K5PPKo2/Hv10A10t7rwNl4YfSCFbxq7yGJpaahYG/g6MHvb4QZPwbQBdms0hzfB
 7TgISaRhq1UP97oSe/hVMrOI6MWAhEMrEnSjF6zP6j7ZFNaSZYpcLBoQjdIQtlklkynz
 RBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792430776; x=1793035576;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2hxDtN+wsubeZBUd54UCnU0Jho0DVSwQCsLM3NWAX+A=;
 b=yeEwgaeHRtHL7J7bi3qpehlBNVSycDXHxBsYu4BlkUKuNiVmDAYgileE7c5MCjNYA1
 2sHGYUPBAoCooEUtLUJXsq3rYOdDr3Feg4RVn2f1llXGmAo84QXBv14Mwz/vP1/gobKO
 3p/i8cRHQpMtQMVUNhiX6ez1EeL8g//G97QAqvg/oglraOb8ZVC8XA/3YR+hENG77yyv
 YZNsY7LsQgyWUgu31AYw99C3CvTwU5JAeVVCWzk0MIPP+jFa9LF1ElKnNL+w4y/L/d6X
 lD0iMGmy17h5BUkB9rLoRbIzV0U2v71pICuVacfWqUa9/ep3q/G+ZbpbUToHkrhYJja6
 V2YQ==
X-Gm-Message-State: AFq9FYJMWG45UmvsWF9JJX2lNVn0xAQ3BJPfWlgOoGqLHzLhDkcvHlVf
 Z4GCWSS6ZWGAVOAxSmGZCH5eY1YYCMtyfUCpUdJT9bMAqWn2rlkt8PHEcABVSKkx8+z84OFLlx2
 imQEpjJVAhJDe3cGVX0WdnMNJHCYsatmQTX9XG2msIH8s1jNHHIrc1ptWoGk5oI3ebw==
X-Gm-Gg: AYBFou3FObYnHOL90gbNkI3YjrE6ZlYD1a3i/V07c58ZNsd07zEFB/xMgA9elzRdtl8
 ozTmm+JFbm0sHqExAIx/POAZhuYU0nydsyAHBqb8i6WAEMVXuowK7uiR/Jh0ycjejwTQg6I7AyW
 7x0WTFcc181NU14ZQe4rbX8C0mPKNo27EkFr8hTQwZtI1fp3XyxjDJyavG2jLLtxH1IBEYQjgCT
 bkpbBxMAbRQVm++EQnIkhPBzwI/L9Ooj9Bh01nk2DBuMBIDtXCyCbFIDzSEv23tV0NcmAhHTWaU
 ha0Nl14bD0o/qO7INcxkqbutTgN6/J20p4NCqAE2ZfPCb9qFaa/N8kl84ks5pbP539iSM2Z7Yv6
 6GJcTwDC+uo5Zx/bTlqdPq1eAQAo+agJuRM5JjWwh3bRn7Os=
X-Received: by 2002:a05:7301:4b14:b0:354:1db3:674e with SMTP id
 5a478bee46e88-361a1370a53mr12850173eec.6.1792430775669; 
 Mon, 19 Oct 2026 10:26:15 -0700 (PDT)
X-Received: by 2002:a05:7301:4b14:b0:354:1db3:674e with SMTP id
 5a478bee46e88-361a1370a53mr12850125eec.6.1792430774950; 
 Mon, 19 Oct 2026 10:26:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-360813b6791sm38243061eec.6.2026.10.19.10.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 10:26:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 01/11] target/hexagon: sort tag_rev_info entries by version
Date: Mon, 19 Oct 2026 10:25:53 -0700
Message-Id: <20261019172603.2625677-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: INd4Jzp3EUgOrUsywvPKA5mnPH0L_eqL
X-Proofpoint-GUID: INd4Jzp3EUgOrUsywvPKA5mnPH0L_eqL
X-Authority-Analysis: v=2.4 cv=H7NOUOYi c=1 sm=1 tr=0 ts=6ad652b8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=XH382VzwAMdzo9DkozgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfXygUcJSkefcpn
 +lEGwHVxouWAcr52iM1cNC4IpWKyNTyX+gJF1Y5hu0zluAGuYzXa7kqtf5wzgK2nXmeH83Tzxx1
 oxnGUmE1MhjIGqXp/5KUbcQ8gy9taoXi5SKzwJW4l4LbwIf16CBWQCecW16yoadIRVsFTE8btLp
 CRzAIGm4Aliwa7TC9zpAhs1ZtSMj+KpxZKDFxpUD74258+js5/ftwsk81avJm+pn/VB2ykOggij
 eP+/wJiixcb5y43XF9zS62tGnpWi5nT1SrdAB9tvx4zgOSIp9HWKDCPUPTftyh9HpasJ/00Bj2c
 NFDoww0MSA5K7m5XpRBLBbcuh4P/+xUBRMcbDppHGT1QY5gXAVizKs/CjeTFihv4KQEyCRQOKhl
 jz9+3OSYNe9vPkZ3Nda3+tXcsYghZ/SclyUQ23DZdWVjDHhTuB6uXLlcrdiewdMDSv6V+FciQDm
 kVAXD0FZHpTTzXxblVg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA2OSBTYWx0ZWRfX1gTfx5JJdlww
 qanbtRIkZKKKtgaweOGe1OA4l5bludsdoJaUXPchM4/+5RXWl/8M1W0SepUI/jnDxUMkdW4SrN7
 ZF4ed+RI6W8neuXcNlQILcbZsPNb51Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_05,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190069
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

VGhlIFY3OSBRRmxvYXQgZW50cmllcyB3ZXJlIHBsYWNlZCBhZnRlciB0aGUgVjgxIGVudHJpZXMu
ICBNb3ZlIHRoZW0KYmVmb3JlIHRoZSBWODEgYmxvY2ssIGFuZCBncm91cCBWNl92Y29udl9iZl9x
ZjMyIHdpdGggdGhlIG90aGVyIFY4MQplbnRyaWVzLiAgTm8gZnVuY3Rpb25hbCBjaGFuZ2UuCgpS
ZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2suYm91dmllckBvc3MucXVhbGNv
bW0uY29tPgpSZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5saWViZWxAb3NzLnF1YWxj
b21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNv
bW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3RhZ19yZXZfaW5mby5jLmluYyB8IDMyICsrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNiBpbnNlcnRpb25z
KCspLCAxNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90YWdfcmV2
X2luZm8uYy5pbmMgYi90YXJnZXQvaGV4YWdvbi90YWdfcmV2X2luZm8uYy5pbmMKaW5kZXggNDFj
ZTNjYjU3MmYuLmIzODBhNmI0NGFlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi90YWdfcmV2
X2luZm8uYy5pbmMKKysrIGIvdGFyZ2V0L2hleGFnb24vdGFnX3Jldl9pbmZvLmMuaW5jCkBAIC02
NDMsMjEgKzY0Myw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdGFnX3Jldl9pbmZvIHRhZ19yZXZf
aW5mb1tYWF9MQVNUX09QQ09ERV0gPSB7CiAgICAgW1kyX2RjZmV0Y2hib19udF0gPSB7IC5pbnRy
b2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiAgICAgW1ky
X2RjemVyb2FfbnRdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhF
WF9WRVJfTk9ORSB9LAogCi0gICAgW1kyX3RsYnBwXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVS
X1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLQotICAgIFtWNl92YWxpZ240XSA9IHsg
LmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLSAg
ICBbVjZfdmVxaGZdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhF
WF9WRVJfTk9ORSB9LAotICAgIFtWNl92ZXFoZl9hbmRdID0geyAuaW50cm9kdWNlZCA9IEhFWF9W
RVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92ZXFoZl9vcl0gPSB7
IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCi0g
ICAgW1Y2X3ZlcWhmX3hvcl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVk
ID0gSEVYX1ZFUl9OT05FIH0sCi0gICAgW1Y2X3ZlcXNmXSA9IHsgLmludHJvZHVjZWQgPSBIRVhf
VkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLSAgICBbVjZfdmVxc2ZfYW5kXSA9
IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwK
LSAgICBbVjZfdmVxc2Zfb3JdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3Zl
ZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92ZXFzZl94b3JdID0geyAuaW50cm9kdWNlZCA9
IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAotICAgIFtWNl92Y29udl9o
X2hmX3JuZF0gPSB7Ci0gICAgICAgIC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVk
ID0gSEVYX1ZFUl9OT05FCi0gICAgfSwKLQogICAgIFtWNl9nZXRfcWZleHRdID0geyAuaW50cm9k
dWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAgIFtWNl9n
ZXRfcWZleHRfb3JhY2NdID0gewogICAgICAgICAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAu
cmVtb3ZlZCA9IEhFWF9WRVJfTk9ORQpAQCAtNjcxLDcgKzY1Niw2IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgdGFnX3Jldl9pbmZvIHRhZ19yZXZfaW5mb1tYWF9MQVNUX09QQ09ERV0gPSB7CiAgICAg
ICAgIC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FCiAg
ICAgfSwKICAgICBbVjZfdmFic19xZjMyX3NmXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y3
OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKLSAgICBbVjZfdmNvbnZfYmZfcWYzMl0gPSB7
IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCiAg
ICAgW1Y2X3Zjb252X3FmMTZfaGZdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVt
b3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAgIFtWNl92Y29udl9xZjE2X3FmMTZdID0gewogICAg
ICAgICAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORQpA
QCAtNjk4LDYgKzY4MiwyMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHRhZ19yZXZfaW5mbyB0YWdf
cmV2X2luZm9bWFhfTEFTVF9PUENPREVdID0gewogICAgIFtWNl92bmVnX3FmMzJfc2ZdID0geyAu
aW50cm9kdWNlZCA9IEhFWF9WRVJfVjc5LCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAogICAg
IFtWNl92c3ViX2hmX21peF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WNzksIC5yZW1vdmVk
ID0gSEVYX1ZFUl9OT05FIH0sCiAgICAgW1Y2X3ZzdWJfc2ZfbWl4XSA9IHsgLmludHJvZHVjZWQg
PSBIRVhfVkVSX1Y3OSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKworICAgIFtZMl90bGJw
cF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9OT05F
IH0sCisKKyAgICBbVjZfdmFsaWduNF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5y
ZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCisgICAgW1Y2X3ZlcWhmXSA9IHsgLmludHJvZHVjZWQg
PSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKyAgICBbVjZfdmVxaGZf
YW5kXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05P
TkUgfSwKKyAgICBbVjZfdmVxaGZfb3JdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAu
cmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtWNl92ZXFoZl94b3JdID0geyAuaW50cm9k
dWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORSB9LAorICAgIFtWNl92
ZXFzZl0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEsIC5yZW1vdmVkID0gSEVYX1ZFUl9O
T05FIH0sCisgICAgW1Y2X3ZlcXNmX2FuZF0gPSB7IC5pbnRyb2R1Y2VkID0gSEVYX1ZFUl9WODEs
IC5yZW1vdmVkID0gSEVYX1ZFUl9OT05FIH0sCisgICAgW1Y2X3ZlcXNmX29yXSA9IHsgLmludHJv
ZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhfVkVSX05PTkUgfSwKKyAgICBbVjZf
dmVxc2ZfeG9yXSA9IHsgLmludHJvZHVjZWQgPSBIRVhfVkVSX1Y4MSwgLnJlbW92ZWQgPSBIRVhf
VkVSX05PTkUgfSwKKyAgICBbVjZfdmNvbnZfaF9oZl9ybmRdID0geworICAgICAgICAuaW50cm9k
dWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3ZlZCA9IEhFWF9WRVJfTk9ORQorICAgIH0sCisgICAg
W1Y2X3Zjb252X2JmX3FmMzJdID0geyAuaW50cm9kdWNlZCA9IEhFWF9WRVJfVjgxLCAucmVtb3Zl
ZCA9IEhFWF9WRVJfTk9ORSB9LAogfTsKIAogI2VuZGlmIC8qIEhFWEFHT05fVEFHX0FSQ0hfVEFC
TEVfSCAqLwotLSAKMi4zNC4xCgo=

