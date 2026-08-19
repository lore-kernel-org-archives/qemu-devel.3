Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED83AC5DF87
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:32:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwVA5-0008N8-U2; Tue, 18 Aug 2026 21:32:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwVA4-0008Mk-Ft
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:32:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwVA2-0008EJ-S4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:32:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkfY22345608
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:32:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mSKFGKY+KrZPOeryydWZ5sEqp5+r+Z//ZA2B/KGKuIE=; b=p6p5v94kWaVz03FK
 dnbvZZT8SplPe1Xl93ZHHMMrxASTI41bzRVVI7vhFZaxxy4LN885qsncNMtjdAPe
 dfzBmsI7VQQqHfIZyK6wgnLzqy2b91oZAeczKfkDlJqGP1MhWjvkk+eJDDoOednA
 RZ8sbQiqh+TKoYlEf5VMTakVJDL2EMoqZ9Mx7VGYlN3/jVhBHLabsTrtwguo/NUi
 q8Klbbke2p+PsPDOJLlIuDyASypz9eKM5UfF2Brp0KRopmon+OjsYTZB53Pyc8X1
 jbY8G2cXJkg6GhPtZvWds66tVXdBJMDwCsxlfAMSRfbajjpmaU01LoTNjsruktK1
 DL8ktA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm8qfw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:32:09 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38e4758ab46so867424a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787103129; x=1787707929; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mSKFGKY+KrZPOeryydWZ5sEqp5+r+Z//ZA2B/KGKuIE=;
 b=UviDMZXazshJoILjUOw0Z94Ch1IUQk2zSuC5pVo/KYtXkS04o8Uk4lnMTV7LjI5swF
 HJ5JVcR+O6V5hnIN1ejm2z0zhqzoh11b/XPUxmLlcV56ZrfsDjSAQJZxkcfc/wKTgiVq
 9nU4a4s2tsp1XvQuBj6ra2rPKK/frR2xQD37oJ62IytwXZgsjakEJTquox+bV3PBhhCk
 1wK8f7YSR7I7mgunI9HiK9/M1Zh1+LvZAABxWVEveiHdIh6Ttvd7bOIisr2MSy97GL2J
 ii31Gjgn1itdyFVEVHnOXPNxbTIp5tsTwUqhq+JxlwDBviy/0g5iwcGuwkYTl1ssrLhb
 /NVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787103129; x=1787707929;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mSKFGKY+KrZPOeryydWZ5sEqp5+r+Z//ZA2B/KGKuIE=;
 b=bSVehfyF8j2ottT//HUZqaq5oKGd9e4lbRKLUZB1AOkawty2cfWGyh+reYxmQgI3JO
 USIQoWGGL5Oy2NhCd0/YKAIaZUjK/GtGccWACnLNtbz/xrTMJ5btY2MtoeuiJCr+dPq7
 kyV+Riw8EeojSWM2+GPL/JohXpciTXexUI5X5DUrpUrJxJNJKg1AOve6Po+FKv82coZv
 DKayO3dmQ0Wfu81Ho8sVBqo3JuSRJ03rzw66QKFLHZyNK8v2xHCkFD/VBxZ/ENwYPn6G
 8b5qRP9vdValzFCsFWss0BeqjOITrAdRgsOzTgzeXSusiWn7xN2E1h5J1ll4AFCrApnI
 xMMg==
X-Gm-Message-State: AOJu0Yw86Bww/GYyCvYGzwN0opwE8tV+e/vthGuyBe64rmsAAtqGwEnV
 M3Q0hx0jQEQ5Gsxn0Tx38765sU5T46ixBrDU35kMqT0AoYEg1VhZqjy30CJIm74ZjSqB1NCcdMn
 +SJWYXVucO7VXY1EjL6Qlis7DMn9I/YbUM+JNYQD6qggE+05xs+3woC3L/29Qv5OkSw==
X-Gm-Gg: AR+sD13CIoKOrNmH9or7w10Vt4Tpkhdb7gvesoajJmWAV4gD/gMJ9LzajoiMoV5TYQc
 AdWHWnKxVJBzHCFGKcM3Pl1S+j8aR017z4kWO3oB2XoKfDXYQGsCKhXqmcSl/u3s3imPiXEC7hE
 CdXGCbHd8aa1t1T4rP6R3E1ySSNrVS9tPXGbcKmzPyy4spiug/3hXhA14oOy+6ycuxDQR6/6EH2
 4J4rD+UX4dcxv+evwvNuiNLvgRAfjdeYRTKhz3GNI7i8ImB+S4/evDB8MkZpmk1aKuIU9QaDTTx
 uhMWhAih7M5iyxYZ9HUkyeWj9PVdSonn6347ScWJxxRvMaGKdEoK7Qi5L7PBvguX99kVgZxgiIh
 IhXyPiFVrmIn9jLUGtFVN3Gan1eSlXPkvMNsCfbvbB/UgcmLd
X-Received: by 2002:a05:6a21:9182:b0:3c3:b57b:645e with SMTP id
 adf61e73a8af0-3cd00df4c1emr2725320637.5.1787103128686; 
 Tue, 18 Aug 2026 18:32:08 -0700 (PDT)
X-Received: by 2002:a05:6a21:9182:b0:3c3:b57b:645e with SMTP id
 adf61e73a8af0-3cd00df4c1emr2725215637.5.1787103128278; 
 Tue, 18 Aug 2026 18:32:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327befa4b94sm1157539eec.13.2026.08.18.18.32.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 18:32:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 10/11] target/hexagon: fix iassign{r,w} to cover all threads
Date: Tue, 18 Aug 2026 18:31:43 -0700
Message-Id: <20260819013144.3264096-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfXwusuauW8oYVb
 U4mYBzovQzD3iPJTirgXTmw7x2621lsdmLYSPOGnxH/dPDltm6mY9HUxYiOMWG2TSY0DLwAGpnj
 6r/+NfPquinxMg8w7TbBXVbER5yd/i2AkWfO9ilQZ1l4MrmCmcOwUQOGG3zfU9kcnVxSSK/sHPl
 TizRB/7UWmL6WAXFFoOwejYcOm5TGIigINLlEEGM8wQO90dypJPOJHHFge+JbWaXrn3WUm7Y6cv
 NgOWkhU35qF8CSZW9w/KqYkoFCsBo7TYZItDHpjDx9hrGnShb5PtyjJ4ALQARwZvQMkeTfNZ9K/
 AN/jXv+KsKQquA/DlUliySld6EH5aY/Xju2FkJxGm94j0d9mzUFd6URGyGVHcGWhODTq9Iacx52
 RyvSuQULROAaGdiqVGW/ZnmcwTzFglrId73OXgiYcH2fp9dBGlq3Jcin19dvv1dUX8V3ihUAmNM
 nUVSgAtjnc4I5tiQ86Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX5Yghf9B7OH+I
 6i59QDck/3NRq6sJn5rraRm8R0yV39uxUHuz5LC0DU89nRJzQ222GjAP3cxbzzKxZ95VW/4ZG6F
 QqhYnYwnyUb0Mr5Czno+17EeiGCMXqE=
X-Proofpoint-GUID: j_J38N8rTucarN9ijywBaZP2TtHSrJ2q
X-Proofpoint-ORIG-GUID: j_J38N8rTucarN9ijywBaZP2TtHSrJ2q
X-Authority-Analysis: v=2.4 cv=J+SaKgnS c=1 sm=1 tr=0 ts=6a850799 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=1MU65uQV28RDXwrdXuMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190009
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

aWFzc2lnbncvaWFzc2lnbnIgd2VyZSBmaWx0ZXJpbmcgQ1BVX0ZPUkVBQ0ggYnkgTU9ERUNUTF9F
LCB0aGUKdGhyZWFkLWVuYWJsZWQgbWFzay4gVGhhdCBtYXNrIHJlZmxlY3RzIHdoZXRoZXIgYSB0
aHJlYWQgaGFzIGJlZW4Kc3RhcnRlZCwgbm90IHdoZXRoZXIgaXQgZXhpc3RzLCBzbyBJTUFTSyB3
cml0ZXMvcmVhZHMgbmV2ZXIgcmVhY2hlZAp0aHJlYWRzIHRoYXQgaGFkbid0IGJlZW4gc3RhcnRl
ZCB5ZXQsIGxlYXZpbmcgdGhlaXIgSU1BU0sgc3RhbGUgb3IKdW5yZWFkYWJsZS4gRHJvcCB0aGUg
TU9ERUNUTF9FIGZpbHRlcmluZyBhbmQgb3BlcmF0ZSBvbiBldmVyeSB0aHJlYWQuCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA0MiArKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDMyIGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKaW5kZXggZGYzMWVkMjQ4OGEuLmUxOWMzYzkxMDg1IDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYwpAQCAtMTYzNyw2MSArMTYzNywzOSBAQCB2b2lkIEhFTFBFUihjc3dpKShDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKIAogdm9pZCBIRUxQRVIoaWFzc2lnbncpKENQ
VUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCiB7Ci0gICAgdWludDMyX3QgbW9kZWN0
bDsKLSAgICB1aW50MzJfdCB0aHJlYWRfZW5hYmxlZF9tYXNrOwogICAgIENQVVN0YXRlICpjcHU7
Ci0gICAgSGV4YWdvbkNQVSAqaGV4X2NwdTsKIAogICAgIEJRTF9MT0NLX0dVQVJEKCk7Ci0gICAg
aGV4X2NwdSA9IGVudl9hcmNoY3B1KGVudik7Ci0gICAgbW9kZWN0bCA9IGhleF9jcHUtPmdsb2Jh
bHJlZ3MgPwotICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGhleF9jcHUtPmdsb2JhbHJl
Z3MsIEhFWF9TUkVHX01PREVDVEwsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52
LT50aHJlYWRJZCkgOiAwOwotICAgIHRocmVhZF9lbmFibGVkX21hc2sgPSBHRVRfRklFTEQoTU9E
RUNUTF9FLCBtb2RlY3RsKTsKIAogICAgIENQVV9GT1JFQUNIKGNwdSkgewogICAgICAgICBDUFVI
ZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNwdSktPmVudik7Ci0gICAg
ICAgIHVpbnQzMl90IHRocmVhZF9pZF9tYXNrID0gMHgxIDw8IHRocmVhZF9lbnYtPnRocmVhZElk
OwotICAgICAgICBpZiAodGhyZWFkX2VuYWJsZWRfbWFzayAmIHRocmVhZF9pZF9tYXNrKSB7Ci0g
ICAgICAgICAgICB1aW50MzJfdCBpbWFzayA9IHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19J
TUFTS107Ci0gICAgICAgICAgICB1aW50MzJfdCBpbnRiaXRwb3MgPSAoc3JjID4+IDE2KSAmIDB4
RjsKLSAgICAgICAgICAgIHVpbnQzMl90IHZhbCA9IChzcmMgPj4gdGhyZWFkX2Vudi0+dGhyZWFk
SWQpICYgMHgxOwotICAgICAgICAgICAgaW1hc2sgPSBkZXBvc2l0MzIoaW1hc2ssIGludGJpdHBv
cywgMSwgdmFsKTsKLSAgICAgICAgICAgIHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFT
S10gPSBpbWFzazsKKyAgICAgICAgdWludDMyX3QgaW1hc2sgPSB0aHJlYWRfZW52LT50X3NyZWdb
SEVYX1NSRUdfSU1BU0tdOworICAgICAgICB1aW50MzJfdCBpbnRiaXRwb3MgPSAoc3JjID4+IDE2
KSAmIDB4RjsKKyAgICAgICAgdWludDMyX3QgdmFsID0gKHNyYyA+PiB0aHJlYWRfZW52LT50aHJl
YWRJZCkgJiAweDE7CisgICAgICAgIGltYXNrID0gZGVwb3NpdDMyKGltYXNrLCBpbnRiaXRwb3Ms
IDEsIHZhbCk7CisgICAgICAgIHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS10gPSBp
bWFzazsKIAotICAgICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiB0aHJl
YWQgIiBUQVJHRVRfRk1UX2xkCi0gICAgICAgICAgICAgICAiLCBuZXcgaW1hc2sgMHglIiBQUkl4
MzIgIlxuIiwgX19mdW5jX18sCi0gICAgICAgICAgICAgICB0aHJlYWRfZW52LT50aHJlYWRJZCwg
aW1hc2spOwotICAgICAgICB9CisgICAgICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIl
czogdGhyZWFkICIgVEFSR0VUX0ZNVF9sZAorICAgICAgICAgICAiLCBuZXcgaW1hc2sgMHglIiBQ
Ukl4MzIgIlxuIiwgX19mdW5jX18sCisgICAgICAgICAgIHRocmVhZF9lbnYtPnRocmVhZElkLCBp
bWFzayk7CiAgICAgfQogICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihpYXNzaWducikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykK
IHsKLSAgICB1aW50MzJfdCBtb2RlY3RsOwotICAgIHVpbnQzMl90IHRocmVhZF9lbmFibGVkX21h
c2s7CiAgICAgdWludDMyX3QgaW50Yml0cG9zOwogICAgIHVpbnQzMl90IGRlc3RfcmVnOwogICAg
IENQVVN0YXRlICpjcHU7Ci0gICAgSGV4YWdvbkNQVSAqaGV4X2NwdTsKIAogICAgIEJRTF9MT0NL
X0dVQVJEKCk7Ci0gICAgaGV4X2NwdSA9IGVudl9hcmNoY3B1KGVudik7Ci0gICAgbW9kZWN0bCA9
IGhleF9jcHUtPmdsb2JhbHJlZ3MgPwotICAgICAgICBoZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGhl
eF9jcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVDVEwsCi0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOwotICAgIHRocmVhZF9lbmFibGVkX21hc2sg
PSBHRVRfRklFTEQoTU9ERUNUTF9FLCBtb2RlY3RsKTsKICAgICAvKiBzcmMgZmllbGRzIGFyZSBp
biBzYW1lIHBvc2l0aW9uIGFzIG1vZGVjdGwsIGJ1dCBtZWFuIGRpZmZlcmVudCB0aGluZ3MgKi8K
ICAgICBpbnRiaXRwb3MgPSBHRVRfRklFTEQoTU9ERUNUTF9XLCBzcmMpOwogICAgIGRlc3RfcmVn
ID0gMDsKICAgICBDUFVfRk9SRUFDSChjcHUpIHsKICAgICAgICAgQ1BVSGV4YWdvblN0YXRlICp0
aHJlYWRfZW52ID0gJihIRVhBR09OX0NQVShjcHUpLT5lbnYpOwotICAgICAgICB1aW50MzJfdCB0
aHJlYWRfaWRfbWFzayA9IDB4MSA8PCB0aHJlYWRfZW52LT50aHJlYWRJZDsKLSAgICAgICAgaWYg
KHRocmVhZF9lbmFibGVkX21hc2sgJiB0aHJlYWRfaWRfbWFzaykgewotICAgICAgICAgICAgdWlu
dDMyX3QgaW1hc2sgPSB0aHJlYWRfZW52LT50X3NyZWdbSEVYX1NSRUdfSU1BU0tdOwotICAgICAg
ICAgICAgZGVzdF9yZWcgfD0gKChpbWFzayA+PiBpbnRiaXRwb3MpICYgMHgxKSA8PCB0aHJlYWRf
ZW52LT50aHJlYWRJZDsKLSAgICAgICAgfQorICAgICAgICB1aW50MzJfdCBpbWFzayA9IHRocmVh
ZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgIGRlc3RfcmVnIHw9ICgoaW1h
c2sgPj4gaW50Yml0cG9zKSAmIDB4MSkgPDwgdGhyZWFkX2Vudi0+dGhyZWFkSWQ7CiAgICAgfQog
CiAgICAgcmV0dXJuIGRlc3RfcmVnOwotLSAKMi4zNC4xCgo=

