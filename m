Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800D606A319
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 00:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZRezgR2o;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IPUMg1o5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJKPh-0002Ux-BA; Tue, 20 Oct 2026 20:42:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKPS-0002Mm-UH
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:42:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xJKPR-00071e-2b
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 20:42:26 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KKtr252442066
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8IyQaTAqm3dKVJ5dLB2G4az8kC5YU0LalyOqFINL4UU=; b=ZRezgR2oc7uu3tuf
 u+R7wy5/r4OSwkDBaEDRbcMbw/OaDkGiuvGeCfwp5toAXO2G/UIXMrRg4ZiI6Pts
 9IfqsJMhyFO1KiJUAaXXde3ycrVgVnGncqwWJygUyG0dCrOeeNySTxLFUtEJfRIk
 vmZLqHAZ/X/ZggdFgMbiUPbFL11IFzFbzlJWbaUsXWP4INW19WEL1RmlF1xaCa4Z
 d2TKmjcshr6IU9iON9+zP4u6L/BGkAd07+AVDrYcfcNNHp7zFCIkD9RTqNZAEX2D
 elRcRllxx1257wNFDrZkyTqQ408vvLRpCszSoG1K5XgByYL6zzARsazkGkOrqBM9
 RlWwbw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hed9hs7av-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 00:42:13 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-33713e5e6daso294369eec.0
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 17:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792543333; x=1793148133; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8IyQaTAqm3dKVJ5dLB2G4az8kC5YU0LalyOqFINL4UU=;
 b=IPUMg1o5J4Qh6ZggeMe13JKX6Ij48wf3OAgt4m7bd/w3XTouFERhCsIhsYrfzZCFqY
 5vQk9+HCxa0s2w+1IPZxWOaL2EjiKBnrvfcOCVpTSfQrz5NP386bmD6xXg4B3w7NTfyT
 0TxGS55t6+M8JF/Napn7bgvj0KtGLY/ZajZyS8GvjKVkAcZb4K2wgmBRGg7YFaMhWRCW
 CeqnxWEKHqdyA6oo2uIZXradbEpocqj9Y5eMybTJU/2Q7giJTLEz3J/PASRJXJ/OWKuH
 PMfcp4u5SWueSDfEOlNQfYCJlA6uAMT4b6WhnAvfidkkpm8kMOfNNn4eREm/KOoOYwBz
 iQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792543333; x=1793148133;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8IyQaTAqm3dKVJ5dLB2G4az8kC5YU0LalyOqFINL4UU=;
 b=al98F1q3Rqb0v7cLLIDhKgXwI23zsGomh4PRAdXfU8nk41pCIGgASeYLexTDdiNaSY
 +OkJyzwsDDQ3MUM3eE7pRg9xwTe1D9+rCjRc4leijrnuFGyMgTIqJFTmcm8y1RGgqMu+
 r+7FYoZB5RSL6DWS1QdUFZ/aGyxD+018zzPwUSW38x9npXqX7qAbJmRvp8GSh2ZH0RBV
 9aUpb0wu7gYJUO5jAmdicnktzqKXZRCyccRrv5V7aQfnPrgwOl86xpekaMxDWYPAb1YW
 qS32k6Rfc2wDSCSxtjs/zrqD7kYYA0TDP0gpyLdeKSkM7xAUwyQMSvknftcgaA8fvgJF
 08cw==
X-Gm-Message-State: AFq9FYLy0hjCMljFh7bTBAm3KDEB/V+ZqKPLgl8aPO0gy/E8TYERBPMQ
 QciDeVGOIFWOyWkfHlZDADhfsYLr7K3vDU1aiaLUAPSu+IunRDcX+RddSs54ueHtMQs5oHGAMCy
 iNmfrBPN+xSK4KEq2pd3jFCOf12A6Yiz4T290nRThWFs9hWi1olr1//7nxnw6e52F6A==
X-Gm-Gg: AYBFou1ilH5UVpA4dJyO08sClaB2hZEqPt6py1zs6TS2TKXQzG8IHOOQzkRuogaNv5X
 qDPtzEBT5maiEcljirODup60slMGK8L9aSXv0Wo06gUbgiTpjO6RMvMr5grRTRCQZneskebpqn9
 EqoMF6HyG1aCkJxxVloRvn6uYJVVm76JEsQN9FJMIFe01D9ivPUBx0w+gNIQJiM1DYXemvw4unh
 CwkcAgo+I2dvelF13E9zHJHw+P6w3ZzfE0D0gWkwx1jI1D2u3zdwoyfh8EeGCTv88u7yepcAWS6
 ++Y3as+v0KqAxR6BPGLrj+5xvn1hb6FhkiYKreCrAE9itVa1uHmiDMuDdqzUXtqTv0qjcEDW/s9
 r+wFitIgoRcpetzXcAadA6qcO0BjifbguSdu7Zb3P6EqcN+g=
X-Received: by 2002:a05:701b:280f:b0:15e:9126:c60f with SMTP id
 a92af1059eb24-190a632ef33mr563496c88.29.1792543332519; 
 Tue, 20 Oct 2026 17:42:12 -0700 (PDT)
X-Received: by 2002:a05:701b:280f:b0:15e:9126:c60f with SMTP id
 a92af1059eb24-190a632ef33mr563463c88.29.1792543331896; 
 Tue, 20 Oct 2026 17:42:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1903d87ab1bsm2005788c88.21.2026.10.20.17.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 17:42:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Alessandro Di Federico <ale@rev.ng>,
 Laurent Vivier <laurent@vivier.eu>, Anton Johansson <anjo@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 14/15] target/hexagon: fix the allocframe framekey
Date: Tue, 20 Oct 2026 17:41:44 -0700
Message-Id: <20261021004145.1693260-15-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
References: <20261021004145.1693260-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=YuKa1IYX c=1 sm=1 tr=0 ts=6ad80a65 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=_X05_UiFBxjwBGZApkgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfX0jh8wbBnFlF6
 rXE9Skpm45Wlb3mIwUiyvw41Dq/nM0WteC1yGwOapBL4/ZKsuoVx9rDt/SmacJP6JNb4LD/zRrw
 DtA5h6utoITELozbHBuDaZoNW8DFTk0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAwMSBTYWx0ZWRfXzptf7yy6qPhA
 DxBl97zoX1KoGVeMV10iUWgATBj4CflCHHk2QbG1ApDQlAcwLswb/8HYtIFjg28PiDyelEjPtt2
 T6mWn2n9tczetzW36IXD5lG4ksR8Aj0F9yY9FkKWxK8lcHvcLkezbqfIuEBw9aE4q9d9O6RvmjM
 yaw7Q617yacagHhhq8WmmRfU+9CUcCf9ZYXetnzqgKgYJ245l3zysY/Wv3DYsjeGp9s0fVNk2xQ
 cVhiVF4rXvxlS9SWwtMhcagMUzduWKEcGtxTBDSur0K/56Sc/Q/ailzOwO0hhLJEBvrn7cPRRRs
 E3GDANk6ZXyYlsooFFIxzmkV6vS8/2PADFAasnhehEmyuspUQmBm0PcxGAbkikZTseVdWjh/JQF
 H5/NnLvYlKZnaq9qBYSqgAIgBHk+EbHsPc4IA2H4Vq/sRN5YJlIwjVAD0cKGuiEe+pEelhR19jm
 iQdDqlXZks/nxMohtPA==
X-Proofpoint-GUID: hdev5AOoG_5AtnBtp18Jz-gMJY9dSl4v
X-Proofpoint-ORIG-GUID: hdev5AOoG_5AtnBtp18Jz-gMJY9dSl4v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_04,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210001
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

VGhlIGZyYW1lIHRoYXQgYWxsb2NmcmFtZSBwdXNoZXMgaXMge0xSLCBGUH0sIGFuZCB3aGF0IGlz
IHNjcmFtYmxlZCBpcwp0aGUgTFIgd29yZDogRlJBTUVLRVkgaXMgWE9SJ2QgaW50byB0aGUgdXBw
ZXIgMzIgYml0cy4gIFRoZSBnZW5lcmF0ZWQKY29kZSBmb3IgZkZSQU1FX1NDUkFNQkxFIGJ1aWx0
IHRoZSBrZXkgZnJvbSBGUkFNRUtFWSBpbiBib3RoIGhhbHZlcyBvZgphIDY0LWJpdCB2YWx1ZSwg
c28gaXQgc2NyYW1ibGVkIEZQIGFzIHdlbGwuICBkZWFsbG9jZnJhbWUgYW5kCmRlYWxsb2NfcmV0
dXJuIG9ubHkgdW5kbyB0aGUgdXBwZXIgd29yZCwgc28gYSBGUCByZXN0b3JlZCBmcm9tIGEgZnJh
bWUKcHVzaGVkIHdpdGggYSBub24temVybyBGUkFNRUtFWSB3YXMgY29ycnVwdC4KClVuY292ZXJl
ZCBieSB0ZXN0aW5nIHNvbWUgYm9vdCBpbWFnZXMgdXNpbmcgUXVSVC4KClJldmlld2VkLWJ5OiBQ
aWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0
YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jIHwgIDIgKy0KIHRlc3Rz
L3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMgICAgICAgICAgICAgICAgfCA2NyArKysrKysrKysrKysr
KysrKysrKysKIHRlc3RzL3RjZy9oZXhhZ29uL21lc29uLmJ1aWxkICAgICAgICAgICAgICAgfCAg
MSArCiAzIGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKIGNy
ZWF0ZSBtb2RlIDEwMDY0NCB0ZXN0cy90Y2cvaGV4YWdvbi9mcmFtZWtleS5jCgpkaWZmIC0tZ2l0
IGEvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYyBiL3RhcmdldC9o
ZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMKaW5kZXggNDljYzExZmRkZDguLjE0
ODQwZDk4NzM3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXIt
aGVscGVycy5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJz
LmMKQEAgLTE5ODksNyArMTk4OSw3IEBAIEhleFZhbHVlIGdlbl9ydmFsdWVfZnNjcihDb250ZXh0
ICpjLCBZWUxUWVBFICpsb2NwLCBIZXhWYWx1ZSAqdmFsdWUpCiAgICAgKnZhbHVlID0gZ2VuX3J2
YWx1ZV9leHRlbmQoYywgbG9jcCwgdmFsdWUpOwogICAgIE9VVChjLCBsb2NwLCAiZ2VuX3JlYWRf
cmVnKCIsICZmcmFtZV9rZXksICIsIEhFWF9SRUdfRlJBTUVLRVkpO1xuIik7CiAgICAgT1VUKGMs
IGxvY3AsICJ0Y2dfZ2VuX2NvbmNhdF9pMzJfaTY0KCIsCi0gICAgICAgICZrZXksICIsICIsICZm
cmFtZV9rZXksICIsICIsICZmcmFtZV9rZXksICIpO1xuIik7CisgICAgICAgICZrZXksICIsIHRj
Z19jb25zdGFudF90bCgwKSwgIiwgJmZyYW1lX2tleSwgIik7XG4iKTsKICAgICBPVVQoYywgbG9j
cCwgInRjZ19nZW5feG9yX2k2NCgiLCAmcmVzLCAiLCAiLCB2YWx1ZSwgIiwgIiwgJmtleSwgIik7
XG4iKTsKICAgICByZXR1cm4gcmVzOwogfQpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24v
ZnJhbWVrZXkuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2ZyYW1la2V5LmMKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjVkNTc5MjkzNDc3Ci0tLSAvZGV2L251bGwKKysrIGIv
dGVzdHMvdGNnL2hleGFnb24vZnJhbWVrZXkuYwpAQCAtMCwwICsxLDY3IEBACisvKgorICogIENv
cHlyaWdodChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRp
YXJpZXMuCisgKgorICogIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVy
CisgKi8KKworI2luY2x1ZGUgPHN0ZGlvLmg+CisjaW5jbHVkZSA8c3RkaW50Lmg+CisKK2ludCBl
cnI7CisKKyNpbmNsdWRlICJoZXhfdGVzdC5oIgorCisvKgorICogYWxsb2NmcmFtZSBwdXNoZXMg
e0xSLCBGUH0sIHNjcmFtYmxpbmcgTFIgd2l0aCBGUkFNRUtFWSwgYW5kIGRlYWxsb2NmcmFtZQor
ICogcmVzdG9yZXMgdGhlbS4gIFB1c2ggYSBmcmFtZSBhbmQgcmV0dXJuIHRoZSB3b3JkcyB0aGF0
IHdlcmUgc3RvcmVkLCBGUAorICogdGhyb3VnaCB0aGUgcmV0dXJuIHZhbHVlIGFuZCBMUiB0aHJv
dWdoIEBscl9zdG9yZWQsIGFuZCB0aGUgRlAgYW5kIExSCisgKiB0aGF0IGRlYWxsb2NmcmFtZSBy
ZXN0b3Jlcy4KKyAqLworc3RhdGljIGlubGluZSB1aW50MzJfdCBmcmFtZV9yb3VuZHRyaXAodWlu
dDMyX3Qga2V5LCB1aW50MzJfdCBmcCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHVpbnQzMl90IGxyLCB1aW50MzJfdCAqbHJfc3RvcmVkLAorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgKmZwX2JhY2ssIHVpbnQzMl90ICpscl9i
YWNrKQoreworICAgIHVpbnQzMl90IGZwX3N0b3JlZCwgc2F2ZWRfZnAsIHNhdmVkX2xyOworCisg
ICAgYXNtIHZvbGF0aWxlKCIlW3NhdmVkX2ZwXSA9IHIzMFxuXHQiCisgICAgICAgICAgICAgICAg
ICIlW3NhdmVkX2xyXSA9IHIzMVxuXHQiCisgICAgICAgICAgICAgICAgICJmcmFtZWtleSA9ICVb
a2V5XVxuXHQiCisgICAgICAgICAgICAgICAgICJyMzAgPSAlW2ZwXVxuXHQiCisgICAgICAgICAg
ICAgICAgICJyMzEgPSAlW2xyXVxuXHQiCisgICAgICAgICAgICAgICAgICJhbGxvY2ZyYW1lKCMw
KVxuXHQiCisgICAgICAgICAgICAgICAgICIlW2ZwX3N0b3JlZF0gPSBtZW13KHIzMClcblx0Igor
ICAgICAgICAgICAgICAgICAiJVtscl9zdG9yZWRdID0gbWVtdyhyMzAgKyAjNClcblx0IgorICAg
ICAgICAgICAgICAgICAicjMxID0gIzBcblx0IgorICAgICAgICAgICAgICAgICAiZGVhbGxvY2Zy
YW1lXG5cdCIKKyAgICAgICAgICAgICAgICAgIiVbZnBfYmFja10gPSByMzBcblx0IgorICAgICAg
ICAgICAgICAgICAiJVtscl9iYWNrXSA9IHIzMVxuXHQiCisgICAgICAgICAgICAgICAgICJmcmFt
ZWtleSA9ICVbemVyb11cblx0IgorICAgICAgICAgICAgICAgICAicjMwID0gJVtzYXZlZF9mcF1c
blx0IgorICAgICAgICAgICAgICAgICAicjMxID0gJVtzYXZlZF9scl1cbiIKKyAgICAgICAgICAg
ICAgICAgOiBbZnBfc3RvcmVkXSAiPSZyIihmcF9zdG9yZWQpLCBbbHJfc3RvcmVkXSAiPSZyIigq
bHJfc3RvcmVkKSwKKyAgICAgICAgICAgICAgICAgICBbZnBfYmFja10gIj0mciIoKmZwX2JhY2sp
LCBbbHJfYmFja10gIj0mciIoKmxyX2JhY2spLAorICAgICAgICAgICAgICAgICAgIFtzYXZlZF9m
cF0gIj0mciIoc2F2ZWRfZnApLCBbc2F2ZWRfbHJdICI9JnIiKHNhdmVkX2xyKQorICAgICAgICAg
ICAgICAgICA6IFtrZXldICJyIihrZXkpLCBbZnBdICJyIihmcCksIFtscl0gInIiKGxyKSwgW3pl
cm9dICJyIigwKQorICAgICAgICAgICAgICAgICA6ICJtZW1vcnkiLCAiZnJhbWVrZXkiKTsKKyAg
ICByZXR1cm4gZnBfc3RvcmVkOworfQorCitzdGF0aWMgdm9pZCBjaGVja19mcmFtZSh1aW50MzJf
dCBrZXksIHVpbnQzMl90IGZwLCB1aW50MzJfdCBscikKK3sKKyAgICB1aW50MzJfdCBscl9zdG9y
ZWQsIGZwX2JhY2ssIGxyX2JhY2s7CisKKyAgICAvKiBPbmx5IExSIGlzIHNjcmFtYmxlZCwgRlAg
aXMgc3RvcmVkIGFzIGlzICovCisgICAgY2hlY2szMihmcmFtZV9yb3VuZHRyaXAoa2V5LCBmcCwg
bHIsICZscl9zdG9yZWQsICZmcF9iYWNrLCAmbHJfYmFjayksIGZwKTsKKyAgICBjaGVjazMyKGxy
X3N0b3JlZCwgbHIgXiBrZXkpOworICAgIGNoZWNrMzIoZnBfYmFjaywgZnApOworICAgIGNoZWNr
MzIobHJfYmFjaywgbHIpOworfQorCitpbnQgbWFpbigpCit7CisgICAgY2hlY2tfZnJhbWUoMCwg
MHgxMjM0ZmZmMCwgMHg1Njc4YWJjYyk7CisgICAgY2hlY2tfZnJhbWUoMHhmMjFmMjBhMCwgMHgx
MjM0ZmZmMCwgMHg1Njc4YWJjYyk7CisKKyAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7
CisgICAgcmV0dXJuIGVycjsKK30KZGlmZiAtLWdpdCBhL3Rlc3RzL3RjZy9oZXhhZ29uL21lc29u
LmJ1aWxkIGIvdGVzdHMvdGNnL2hleGFnb24vbWVzb24uYnVpbGQKaW5kZXggYTZhY2U0Yzc3YzIu
LjBmZDYyY2U3ZTRjIDEwMDY0NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZAor
KysgYi90ZXN0cy90Y2cvaGV4YWdvbi9tZXNvbi5idWlsZApAQCAtNjgsNiArNjgsNyBAQCB0ZXN0
cyArPSB7CiAgICdvdmVyZmxvdy5jJzogeydjZmxhZ3MnOiBjZmxhZ3MsICdleGVfbmFtZSc6ICdo
ZXgtb3ZlcmZsb3cnfSwKICAgJ3ByZWdfYWxpYXMuYyc6IHsnY2ZsYWdzJzogY2ZsYWdzfSwKICAg
J2R1YWxfc3RvcmVzLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCisgICdmcmFtZWtleS5jJzogeydj
ZmxhZ3MnOiBjZmxhZ3N9LAogICAnbXVsdGlfcmVzdWx0LmMnOiB7J2NmbGFncyc6IGNmbGFnc30s
CiAgICdtZW1fbm9zaHVmLmMnOiB7J2NmbGFncyc6IGNmbGFnc30sCiAgICdtZW1fbm9zaHVmX2V4
Y2VwdGlvbi5jJzogeydjZmxhZ3MnOiBjZmxhZ3N9LAotLSAKMi4zNC4xCgo=

