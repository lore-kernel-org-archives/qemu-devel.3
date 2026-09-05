Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2C6C624D3
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 18:10:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2uqE-0002r4-AT; Sat, 05 Sep 2026 14:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq6-0002iU-CO
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2uq4-0001Oc-JT
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 14:10:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685Hc9OI3779986
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 18:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XIiyCpeLDahOcIoGv1yfJm441SYgpuIykRR8nRioS+c=; b=m0kMYYlQ6CJ4Fpss
 OasNK4sr6UJI0MVc9Yz34U1J3g7BtnoEezmIHiPD61UOhIyk3QDWxVfmIvZGUnYA
 TgED+OrykjLy6dLtErcDHq9ssN1IVNmfJqdLHKEF9yhDfK5tZSLYyZf/1tfsNAcH
 JnwNqzdk0pPk/7UwsyuM/0J7aTvF5AyCfPQSr6MbgjT/gVnlf1d5DMS8k9Dp08ea
 2iM82HMPnV821mlgvs0Cr9zmNTQjBtQXDbfBL/H6mppaqMvpmUX2mvVHQgi6cfza
 6wXgzE3ZNhyZoooF1qAD664r7uKdE/Jg6jlc925t8Y/G+GWxPqPVMPZgbwOeumFb
 Tmh+Sg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gga1s23gg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 18:09:54 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d932ef41c4so31975445ad.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788631794; x=1789236594; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XIiyCpeLDahOcIoGv1yfJm441SYgpuIykRR8nRioS+c=;
 b=fs4B4DizAuPUKVO+YgU86a23pVe1613U6uJdCic5VKJ8w3XHU0nSC6qDaExFiJARCS
 tVndn09ZGjy46rWogwiHLrp4XSRsWAiO9pWnQlYwpT/ocxFzejtkdul4u8hDXw4xGs9l
 PEAgS5R9vxxrpkbdaQgZ25tpC9QYVvWZDP5vCTS//U2yPKWJds7foubJmUiEFUZVoxjs
 HsiGsPYD6Yw8sgfHz6mQPOM9dZPy10IqjevsDam2d7PjExqL1CNcD2/9oLdgp3tSQlGv
 o+5MHJqC8NKvnn9LvWn+4PruXwn3NQ9O0I0IECyNl5KPOrHdvqY8XGMmiCaE/yNUGb8T
 E3Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788631794; x=1789236594;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XIiyCpeLDahOcIoGv1yfJm441SYgpuIykRR8nRioS+c=;
 b=k5JC72zyl6MEINsWQg9v62J7Ye9uJc8DmStxl2usRUOtxwYUL1/7oXlBN7ukmRG9nW
 4SMOxkPFr1AU7pA8E8MhXC225c6HWHfzZQ7+C7gD+EU8Nj1MMnRtFguLF48FcFA0HImG
 TdvlyKbGaOqNDOYATflp/LgQUZKh8OajZX1B/L72RjARN3DtkoL7bQhXv/MujPitOEgn
 yCxNqZAfh3dfqnhAwpRuMXN/m/XjoHKKhQTy9tGxhOPOTPK0x/rm0s1EmOI6OdkwSOLw
 cLySUk8Os90t9xn1T3eCkCYRkOJM8Y8T40hsHiFGCyLcyjwTK9c4FuPLMKsJpeq1gY6D
 ghDQ==
X-Gm-Message-State: AFuF++mey4o7zIlLkBzifSvpKfC9YGZ1sf5pkHdbS/fhW26HPCjv3o7r
 13lB256k+9Pi99i2nlL8EskvAN+Fm3k+JFNSx5u4kVJXSCKAjJ+knTRoEdjZgS42/c1Fr4D5cLP
 iHczXJu8iRwrUBSO5DTgOdZCM7aai1/mQCjZ6DsIFGkhdEjDisF46pYHwomd8+CfUFw==
X-Gm-Gg: AYBFou0PAkO94zvHD185Kr9taX8ewin7UEFOaR4Tlf9HZJ72zEZXSyYB/lwwhceMZ9C
 FzecRzZjwEmbXD3+32UsAvdQz/RbQVMV4uQjwDgOe94LEN/9GAFBONFdm+mmaH5e2ew77z6v1WN
 +KcGNjyWHT/ybUnYAspFbHxVfrYHxzrcQefS0oQUpukJudjfzIW6IRUgPcqB6p/o7Wj6FurpWft
 jDOBkm/AY0Ihmo4Y1OXHEpijlRFRu6rOiH5eYsfQGaFEuLMe+KUE7DF40j5wqlekApDMtj+TVLT
 yJuOAfGYGi745RDrFKWSCdAHsQpF2C5ElkH2ON08RTuHuAWaYLkkmAhgO8H3em3IxGFoA1jWhjr
 KTs9gc5ffJMA0G/XiLHWmVrSVj4CwMIIhajTuwKqCjnKXPffV
X-Received: by 2002:a17:903:b07:b0:2d2:72b6:556b with SMTP id
 d9443c01a7336-2dafb0b28b5mr182025045ad.13.1788631793986; 
 Sat, 05 Sep 2026 11:09:53 -0700 (PDT)
X-Received: by 2002:a17:903:b07:b0:2d2:72b6:556b with SMTP id
 d9443c01a7336-2dafb0b28b5mr182024805ad.13.1788631793532; 
 Sat, 05 Sep 2026 11:09:53 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339a534df1sm17985505eec.7.2026.09.05.11.09.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 11:09:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, sid.manning@oss.qualcomm.com
Subject: [PATCH 01/17] tests/tcg/hexagon: fix undefined signed left shift in
 circ.c
Date: Sat,  5 Sep 2026 11:09:33 -0700
Message-Id: <20260905180949.1852673-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=WMBPmHsR c=1 sm=1 tr=0 ts=6a9c5af2 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=czf7IwGEd3W-wTYbEmAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX1yyrP5JVaOj2
 SUykIWmWwtoZL6E5yRJw7nRIH2skgjnoKkBBcyrgSn8OcIQrXgFrpO4vLcVXm3lsQrYCSJHwjIC
 8R55kQELDg2PPcfQsH/T/VvmgUonjxc=
X-Proofpoint-GUID: rX6GnbysHANtRgn7IGrVlFXUgsrfGIaG
X-Proofpoint-ORIG-GUID: rX6GnbysHANtRgn7IGrVlFXUgsrfGIaG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIwMSBTYWx0ZWRfX2RwkgKD+/D0l
 X2iNjZhtx4fa9uB9ztB/q0TnaC4wyGTv/PtmZlpY8VkdoGCepYMjeVSjTwSPX2p/F7V+Ok1/1uW
 i566Ry245grjshVrBo71ITqpM66NPcPAfGqzAaqAxVpy+dBychy/EiZ5/EeqWR/k9a6GFd5nx4E
 AqyPHeTubo/UrODFJqdhM4XE4q2Jo4yZstPEWnwRxNnx4cJ6K+FcreBdFZTrkU7xhWb0xKzqw4z
 2P30SXjAVK98j9rsIKpZ2MLt2W4BoSc7sCZJkADeyLSs4h6a/t/ArnQ0qHNA90C5sVfUg6i5Iwx
 71ATnRn05sHGn3CMQ6/xQAuNca9+KQwyRYRAsXh8ipHMnvjSK1TVQKjKERtlRYMmBNQE5e59IP9
 /t9cozUMLszUs7AiSmqffk0OreKUlj9Ark75Zh5PyRNbz95siEHqr+rhVzlJtdMtgYLScs3kYsq
 8h3GtO1HTQ9sBI1ksIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609050201
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

Q2FzdCBvcGVyYW5kcyB0byB1aW50MzJfdCBiZWZvcmUgbGVmdC1zaGlmdGluZyBpbiBidWlsZF9t
cmVnKCkgdG8KYXZvaWQgdW5kZWZpbmVkIGJlaGF2aW9yIHdoZW4gdGhlIHNoaWZ0IHJlc3VsdCBv
dmVyZmxvd3MgaW50MzJfdC4KRm91bmQgd2l0aCBVQlNhbi4KClNpZ25lZC1vZmYtYnk6IEJyaWFu
IENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4YWdv
bi9jaXJjLmMgfCA2ICsrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy90Y2cvaGV4YWdvbi9jaXJjLmMgYi90ZXN0
cy90Y2cvaGV4YWdvbi9jaXJjLmMKaW5kZXggYWI5NDllYmVmMWMuLjJhMTVjMzI0MjQyIDEwMDY0
NAotLS0gYS90ZXN0cy90Y2cvaGV4YWdvbi9jaXJjLmMKKysrIGIvdGVzdHMvdGNnL2hleGFnb24v
Y2lyYy5jCkBAIC05Nyw5ICs5Nyw5IEBAIElOSVQoZGJ1ZiwgTkRPQkxTKQogICovCiBzdGF0aWMg
aW50MzJfdCBidWlsZF9tcmVnKGludDMyX3QgaW5jLCBpbnQzMl90IEssIGludDMyX3QgbGVuKQog
ewotICAgIHJldHVybiAoKGluYyAmIDB4NzgwKSA8PCAyMSkgfAotICAgICAgICAgICAoKEsgJiAw
eGYpIDw8IDI0KSB8Ci0gICAgICAgICAgICgoaW5jICYgMHg3ZikgPDwgMTcpIHwKKyAgICByZXR1
cm4gKCh1aW50MzJfdCkoaW5jICYgMHg3ODApIDw8IDIxKSB8CisgICAgICAgICAgICgodWludDMy
X3QpKEsgJiAweGYpIDw8IDI0KSB8CisgICAgICAgICAgICgodWludDMyX3QpKGluYyAmIDB4N2Yp
IDw8IDE3KSB8CiAgICAgICAgICAgIChsZW4gJiAweDFmZmZmKTsKIH0KIAotLSAKMi4zNC4xCgo=

