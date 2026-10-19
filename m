Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA041CCF2D3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 05:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIgJY-0006cp-Gk; Mon, 19 Oct 2026 01:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgJC-0006Xw-8O
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:53:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIgJ7-0001IX-5X
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 01:53:17 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J4jfqs2268349
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xJoW5jHc+0suwOlKzY+Ots8Plvjs6H8MnOII1ZUOKso=; b=k4/4msYfU926yd6u
 hJgm2FW0OHbfIVB4L0j/IWRJ8R3oEHTo66Ts0MlpSLOKhbJZKlBHx1zb+OAXRd+w
 +sFufLL6iO+c56r0gJeig5Ve2U8jZAPtVtgYtuRfsZkiMQDiUtRbfTbL0fcZ2Lpw
 Vn1oi1GgDa/NXWSnMIt+spBsaLXlKdkxIhifl8OFFCoqdn7+7E6k/guEYTX96+KU
 hVpbvMH/mgH+5xrd1Z6kOwu6TajUd6tAm14XXAPCPCfiYMt3vHAGDtIBP6NNU8BG
 F2dHMcFMBRHN+EERctTZA9/xFjuYwJcwTR7w1EhRbilUCx1gU8LAZ0brOeq2FuP8
 EqzWSg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hc0kxn5s5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 05:53:08 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33713e5e6daso2571352eec.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 22:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792389188; x=1792993988; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xJoW5jHc+0suwOlKzY+Ots8Plvjs6H8MnOII1ZUOKso=;
 b=S/12aZGwKaHkagZPAagsng/05GVAuK7qTjlUDajedzKOspT7InebgUuwNAIg+0tB6c
 /6g57bPCboxW6IsmQK1uyjFMTimegqlaiJSsT/3+vSe/Y7G/0kZI/Gry/AG80s6yxdE6
 WC94W80gTDz+VoeB/P2O8oOtUAhkn4xCuIQYZeTXOHQtgh9109P0uETVNInPOlEcb9yq
 FR66PnqSXpIsg2C5wO3dpeafq7HKe96VeO2YOKJ3GDI/VmfNyBSfT+ayhbw48bD+lxe/
 DxDH4YnRn3L540t6ZP92QCGjgIhu+alClSCOl1nSfnIwdIWq3bCIR/SBw+ykLW+PZ41M
 lkmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792389188; x=1792993988;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xJoW5jHc+0suwOlKzY+Ots8Plvjs6H8MnOII1ZUOKso=;
 b=z24qBOr3YCDeHez/T59/kAE9VIfyDcnYseH8Pu0CGFj22tA/yBD4QJhxyqXhw5niW4
 q4dfjLB17k0uxQTCehsnQ54S3MVN4xi4DEDE2YiPkbKYNFRSaJXjNcG8s/+5XlGrSojC
 MvapOseBsfcbIlLtMeqzBvndPjvpM3cHPlWt6qMra5KO9TN4Jh6iEnAW83/O8RWdcq3Q
 XHTcA7iryzevvoCp94+kiUbPmkfk5F6YIqGNi5K9AazK+wWIJobzztnpU6DC2KaTWq9b
 YD8aGtI3gf1KB7LFCOgvZLjzF2fmCKYyJhGNf7pQ2SXAxSPdX3AfCWktTdPlGMsvuvRb
 23gQ==
X-Gm-Message-State: AFq9FYL8aaU47eN/M/49kb03SxGTQ7zXibIJZ6Vnj+1sBltBvgodd57U
 Zfj2nuzhI/Fp382n7f1PTmvHi4fg7VeCEaLcQYX4gomzYHSG//JyyNXvVT86YuM4g3g6aZI0DWx
 WaAC2RJ/QsUbA+PiYxNJZsK2hzaUfYdDW0g8JH0o5o0Oo+UrG2uSnNLeHE95JFpCHmA==
X-Gm-Gg: AYBFou1qOaVF9CuWeKwEk6/xeCtE9AHqM9wV/LuTOcpdGzr2S6IKcyoRAKAXjDLJv85
 Kw3H4/22uaxdk8OegjdHFJVDdBo3ni8TwzKXZ35eJ7ZrPNXbYXOoGw6PjLlItM8ey4vU501sGm3
 acRuAtYa2p4UtAgKg7E98ROGX1sw0gSqpMauDMRjI4nVvO8TPR9eDZ4ce5hdjZlNRW7EsSH/C+t
 CccnMN12XZv6Hivjz/d6E3BJtpRAQaErP+KnisPzqzYrs1NWHM9odAOLCF7x2D6TpPTqQ9P6Zvp
 e4hSco7aX/SawHTVOxHVFAR7lxr1fLOn04iKIRXR9LFnNzhvw8ioQFd/zzN52j0ZAPZ/QcTpUc0
 gsPald6Rc5WIAuDHVOE+KoCbFddjA2JTfchJD2YvVvCZ6pvI=
X-Received: by 2002:a05:7022:5f13:b0:159:2c6d:fcc3 with SMTP id
 a92af1059eb24-18512e254abmr7549056c88.33.1792389187963; 
 Sun, 18 Oct 2026 22:53:07 -0700 (PDT)
X-Received: by 2002:a05:7022:5f13:b0:159:2c6d:fcc3 with SMTP id
 a92af1059eb24-18512e254abmr7549030c88.33.1792389187346; 
 Sun, 18 Oct 2026 22:53:07 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1831b75ac0fsm25672781c88.15.2026.10.18.22.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 22:53:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH 11/14] hw/hexagon: add v79NA1 machine
Date: Sun, 18 Oct 2026 22:52:42 -0700
Message-Id: <20261019055245.1457795-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
References: <20261019055245.1457795-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfX5QNpkIucgGlg
 fMSp8c03x0To2Wj8u4dMxqxKo8cU1NTU7sX0K4v91JkDE5bJNcBv40nEWN1nmxg3j3xcb9xDOQs
 jXTYAKCdpsCHH34WGZ1JJAkdGwcL1dY=
X-Authority-Analysis: v=2.4 cv=JpZkP84C c=1 sm=1 tr=0 ts=6ad5b045 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=7BVmsqUksLU-FW-GvuIA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDAyMyBTYWx0ZWRfXyjdaJFTR71ZS
 14INdvPBkktzkPZSsJWhT1W4U8jY/4yOBcGh0Zcr6weGM+/xCt/DFaZDQ0NMWLXPeas4KNBILHR
 lBIc0ml/7RHo/WRr4k/2OhbKCQYBLY7UT12Vdl7MyEPkTkc0Gaa9UUkfbNTpdybwof1F8mvm1pl
 Z8443xj48Xvv/fn5sQspuZ0/+Hbz9rSCf7tkJOsHSpc28VKO7nZLfPHAEgu9XtUqXODT8iNF8fd
 UVS9z9qIasXO2/9Owty5ygHJqD4GP052z6664hDb+TuWlPNY2kYPdKrt/SGSYp4OSyPweyTdp60
 wxtmDy3m/vOErRFkJ9TrktG9fQNm1rTGobZM0DJvTwaBRAxnU/Q9m+D4rmjt0yquWN+oCVrftO/
 xDARZM++oBflNNjuLpZLvoV2M5WoGR+bNVSJhaC2hWZBWK2W1zL4lzV6WvysMubehVlnFV2gFGv
 g7XB6u/7CMiaySvqc5w==
X-Proofpoint-ORIG-GUID: yT3MFSVRCypNZgur52q4zXjZA9MeqCmV
X-Proofpoint-GUID: yT3MFSVRCypNZgur52q4zXjZA9MeqCmV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190023
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

QWRkIHRoZSBIZXhhZ29uIFY3OU5BXzEgc2ltdWxhdG9yIG1hY2hpbmUsIHdpdGggdGhlIGNvbmZp
ZyB0YWJsZSBvZiB0aGUKdjc5IGNvcmUgYW5kIGVpZ2h0IENQVXMgYnkgZGVmYXVsdC4KClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBp
bmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oICAgICAgICAgfCAgMSArCiBody9oZXhhZ29uL21h
Y2hpbmVfY2ZnX3Y3OW5hXzEuaC5pbmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgICAgICAgICAgICAgfCAyMiArKysrKysrKysrKysr
KysrKysKIDMgZmlsZXMgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAw
NjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfdjc5bmFfMS5oLmluYwoKZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uLmggYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5o
CmluZGV4IDI2YjBhMWIzNzU3Li43ZDE1YTllMWViMCAxMDA2NDQKLS0tIGEvaW5jbHVkZS9ody9o
ZXhhZ29uL2hleGFnb24uaAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbi5oCkBAIC0y
OCw2ICsyOCw3IEBAIHR5cGVkZWYgZW51bSB7CiAgICAgdjcxX3JldiA9IDB4OGM3MSwKICAgICB2
NzNfcmV2ID0gMHg4YzczLAogICAgIHY3M21fcmV2ID0gMHhjYzczLAorICAgIHY3OV9yZXYgPSAw
eDhjNzksCiAgICAgdjgxX3JldiA9IDB4ODc4MSwKICAgICB2ODFfc2M4NDgweHBfcmV2ID0gMHg4
MDgxLAogICAgIHY4MWRnYl8xX3JldiA9IDB4Y2M4MSwKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24v
bWFjaGluZV9jZmdfdjc5bmFfMS5oLmluYyBiL2h3L2hleGFnb24vbWFjaGluZV9jZmdfdjc5bmFf
MS5oLmluYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uNzBhN2FlNThi
YzUKLS0tIC9kZXYvbnVsbAorKysgYi9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3Y3OW5hXzEuaC5p
bmMKQEAgLTAsMCArMSwzNCBAQAorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b3ItbGF0ZXIgKi8KKworc3RhdGljIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmln
IHY3OW5hXzEgPSB7CisgICAgLmNmZ2Jhc2UgPSAgICAgICAgICAgICAweGQ4MTgwMDAwLAorICAg
IC5sMnRjbV9zaXplID0gICAgICAgICAgMHgwMDAwMDAwMCwKKyAgICAubDJ2aWNfYmFzZSA9ICAg
ICAgICAgIDB4ZmM5MTAwMDAsCisgICAgLmwydmljX3NpemUgPSAgICAgICAgICAweDAwMDAxMDAw
LAorICAgIC5jc3JfYmFzZSA9ICAgICAgICAgICAgMHhmYzkwMDAwMCwKKyAgICAucXRtcl9yZWdp
b24gPSAgICAgICAgIDB4ZmM5MjEwMDAsCisgICAgLmNmZ3RhYmxlID0geworICAgICAgICAubDJ0
Y21fYmFzZSA9IDB4MDAwMGQ4MDAsIC5zdWJzeXN0ZW1fYmFzZSA9IDB4MDAwMDIwMDAsCisgICAg
ICAgIC5ldG1fYmFzZSA9IDB4MDAwMGQ4MTksIC5sMmNmZ19iYXNlID0gMHgwMDAwZDgxYSwKKyAg
ICAgICAgLmwxczBfYmFzZSA9IDB4MDAwMGQ5MDAsIC5heGkyX2xvd2FkZHIgPSAweDAwMDAzMDAw
LAorICAgICAgICAuZmFzdGwydmljX2Jhc2UgPSAweDAwMDBkODFlLCAuanRsYl9zaXplX2VudHJp
ZXMgPSAweDAwMDAwMDgwLAorICAgICAgICAuY29wcm9jX3ByZXNlbnQgPSAweDAwMDAwMDBkLCAu
ZXh0X2NvbnRleHRzID0gMHgwMDAwMDAwNiwKKyAgICAgICAgLnZ0Y21fYmFzZSA9IDB4MDAwMGQ5
MDAsIC52dGNtX3NpemVfa2IgPSAweDAwMDAyMDAwLAorICAgICAgICAubDJ0YWdfc2l6ZSA9IDB4
MDAwMDA0MDAsIC5sMmVjb21lbV9zaXplID0gMHgwMDAwMDQwMCwKKyAgICAgICAgLnRocmVhZF9l
bmFibGVfbWFzayA9IDB4MDAwMDAwZmYsIC5sMmxpbmVfc2l6ZSA9IDB4MDAwMDAwODAsCisgICAg
ICAgIC5sMml0Y21fYmFzZSA9IDB4MDAwMGQ4MDAsIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDYs
CisgICAgICAgIC5odnhfdmVjX2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LCAuY29wcm9jMl9yZWcw
ID0gMHgwMDAwMDA0MCwKKyAgICAgICAgLmNvcHJvYzJfcmVnMSA9IDB4MDAwMDAwMjAsIC52Mnhf
bW9kZSA9IDB4MDAwMDAwMDEsCisgICAgICAgIC5jb3Byb2MyX3JlZzIgPSAweDAwMDAwMDEwLCAu
Y29wcm9jMl9yZWczID0gMHgwMDAwMDAyMCwKKyAgICAgICAgLmNvcHJvYzJfcmVnNCA9IDB4MDAw
MDAwMjAsIC5jb3Byb2MyX3JlZzUgPSAweDAwMDAwMDA4LAorICAgICAgICAuY29wcm9jMl9yZWc2
ID0gMHgwMDAwMDAxNiwgLmNvcHJvYzJfcmVnNyA9IDB4MDAwMDAwMDgsCisgICAgICAgIC5hY2Rf
cHJlc2V0ID0gMHgwMDAwMDAwMSwgLm1uZF9wcmVzZXQgPSAweDAwMDAwMDAxLAorICAgICAgICAu
bDFkX3NpemVfa2IgPSAweDAwMDAwMDIwLCAubDFpX3NpemVfa2IgPSAweDAwMDAwMDIwLAorICAg
ICAgICAubDFkX3dyaXRlX3BvbGljeSA9IDB4MDAwMDAwMDIsIC52dGNtX2Jhbmtfd2lkdGggPSAw
eDAwMDAwMDgwLAorICAgICAgICAucmVzZXJ2ZWQ0ID0gMHgwMDAwMDAwMSwgLmNvcHJvYzJfY3Z0
X21weV9zaXplID0gMHgwMDAwMDAwYSwKKyAgICAgICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4
MDAwMDAwZTAsIC5jYXBhY2l0eV9kb21haW4gPSAweDAwMDAwMDgwLAorICAgICAgICAuYXhpM19s
b3dhZGRyID0gMHgwMDAwNDAwMCwgLmNvcHJvYzJfaW50OF9zdWJjb2x1bW5zID0gMHgwMDAwMDAw
MiwKKyAgICAgICAgLmNvcmVjZmdfcHJlc2VudCA9IDB4MDAwMDAwMGQsIC5jb3Byb2MyX2ZwMTZf
YWNjX2V4cCA9IDB4MDAwMDAwMDcsCisgICAgICAgIC5BWElNMl9zZWNvbmRhcnlfYmFzZSA9IDB4
MDAwMDQwMDAsIC5BWElNX2RhdGFfd2lkdGggPSAweDAwMDAwMTAwLAorICAgIH0sCit9OwpkaWZm
IC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2Rz
cC5jCmluZGV4IDg4MjRmZTEwYTU5Li45ZjZmMzRlZjliZSAxMDA2NDQKLS0tIGEvaHcvaGV4YWdv
bi9oZXhhZ29uX2RzcC5jCisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwpAQCAtMzAsNiAr
MzAsNyBAQAogCiAjaW5jbHVkZSAibWFjaGluZV9jZmdfdjY2Z18xMDI0LmguaW5jIgogI2luY2x1
ZGUgIm1hY2hpbmVfY2ZnX3Y2OG5fMTAyNC5oLmluYyIKKyNpbmNsdWRlICJtYWNoaW5lX2NmZ192
NzluYV8xLmguaW5jIgogI2luY2x1ZGUgIm1hY2hpbmVfY2ZnX3Y4MWRnYl8xLmguaW5jIgogI2lu
Y2x1ZGUgIm1hY2hpbmVfY2ZnX3Y4MXFhXzEuaC5pbmMiCiAKQEAgLTIwNSw2ICsyMDYsMjIgQEAg
c3RhdGljIHZvaWQgdjgxZGdiXzFfY29uZmlnX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQog
ICAgIGhleGFnb25fY29tbW9uX2luaXQobWFjaGluZSwgdjgxZGdiXzFfcmV2LCAmdjgxZGdiXzEp
OwogfQogCitzdGF0aWMgdm9pZCB2NzluYV8xX2NvbmZpZ19pbml0KE1hY2hpbmVTdGF0ZSAqbWFj
aGluZSkKK3sKKyAgICBoZXhhZ29uX2NvbW1vbl9pbml0KG1hY2hpbmUsIHY3OV9yZXYsICZ2Nzlu
YV8xKTsKK30KKworc3RhdGljIHZvaWQgdjc5bmFfMV9pbml0KE9iamVjdENsYXNzICpvYywgY29u
c3Qgdm9pZCAqZGF0YSkKK3sKKyAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhv
Yyk7CisKKyAgICBtYy0+ZGVzYyA9ICJIZXhhZ29uIFY3OU5BXzEiOworICAgIG1jLT5pbml0ID0g
djc5bmFfMV9jb25maWdfaW5pdDsKKyAgICBpbml0X21jKG1jKTsKKyAgICBtYy0+ZGVmYXVsdF9j
cHVfdHlwZSA9IFRZUEVfSEVYQUdPTl9DUFVfVjc5OworICAgIG1jLT5kZWZhdWx0X2NwdXMgPSA4
OworfQorCiBzdGF0aWMgdm9pZCB2ODFkZ2JfMV9pbml0KE9iamVjdENsYXNzICpvYywgY29uc3Qg
dm9pZCAqZGF0YSkKIHsKICAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7
CkBAIC0yNTgsNiArMjc1LDExIEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBoZXhhZ29uX21hY2hp
bmVfdHlwZXNbXSA9IHsKICAgICAgICAgLnBhcmVudCA9IFRZUEVfSEVYQUdPTl9EU1BfTUFDSElO
RSwKICAgICAgICAgLmNsYXNzX2luaXQgPSB2NjhuXzEwMjRfaW5pdCwKICAgICB9LAorICAgIHsK
KyAgICAgICAgLm5hbWUgPSBNQUNISU5FX1RZUEVfTkFNRSgiVjc5TkFfMSIpLAorICAgICAgICAu
cGFyZW50ID0gVFlQRV9IRVhBR09OX0RTUF9NQUNISU5FLAorICAgICAgICAuY2xhc3NfaW5pdCA9
IHY3OW5hXzFfaW5pdCwKKyAgICB9LAogICAgIHsKICAgICAgICAgLm5hbWUgPSBNQUNISU5FX1RZ
UEVfTkFNRSgiVjgxREdCXzEiKSwKICAgICAgICAgLnBhcmVudCA9IFRZUEVfSEVYQUdPTl9EU1Bf
TUFDSElORSwKLS0gCjIuMzQuMQoK

