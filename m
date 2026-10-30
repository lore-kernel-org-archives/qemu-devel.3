Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5FE606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 22:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=fJy1BOaU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NpECit97
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMumM-0000eu-T8; Fri, 30 Oct 2026 18:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumK-0000dm-J5
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xMumI-0003po-OH
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 18:08:52 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULtWel3568571
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6B5llGzE3Li3ncDt78a0S1Qd/D3gz2e0PVOqyGUtwWA=; b=fJy1BOaUMA9TkAVk
 Sm8ZK6G/HvRck/0nd8r3Q4bRe+3a98JlvcfzMoQXvu4HN984nw1H274QAwH+Sz2/
 zg6cRGXabhqjA0GFhU7g2g3xAA5IeIkoGqE1j/+lX3hXRL4jh7y3FGBDI5Akdzeh
 JE1GjvhtHyTzr4mtRfl8cTSJlKdHXG6EVh2+zgwO+AgsCT1ZOWC/SMGrC7WLnAtt
 d+0VOZmkHjiDUUlZ3mZNbgbs7dNoXw/yUEsMprz4NcjQRoNMGILPrqcTIPRbihum
 ++Ze1Q2F+DQy9EDqi6SE3/wkMhc2j1tNXlnHL4OQUfhKKEP7shnb7Mta/jPMIleT
 Hll/KQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0g5cg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 22:08:49 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-36a3451ea93so1847164eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793398129; x=1794002929; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6B5llGzE3Li3ncDt78a0S1Qd/D3gz2e0PVOqyGUtwWA=;
 b=NpECit97UVjcnvqWyyoR1ckHm6bPUtLANp+487QrScDZ7TCKI0CXB46eHVlwIcQcVl
 jVx8CfW+KYy6Jq7gAHNGLNKnrametAk80PWMeE6O+5aAJYIQ0zNawKEo5qd2FJOVgna+
 0yEpEmWc7ZgaW0fJOSqFZCBKIbNuMGBLCYHsMvGnzdKLu48weX8IcFHNV0ll134ijCN+
 qxjG+FTM08jbm40bq5kZHXUSd0ED63YRGSkkX9VNrUbtNIzu79zd8f3LVKTI2SRBOPTm
 l1vg7rMmD/ODKuK+4dY4MPtmFhtv+wuSaCzqPKbwv3fNDz6jzpn6jb0aq1r+OLEN6LPf
 mDJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793398129; x=1794002929;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6B5llGzE3Li3ncDt78a0S1Qd/D3gz2e0PVOqyGUtwWA=;
 b=Cm/gjL7zBvoG/9UjRgkHldMQYiXpXYkN59RMmFpixms0XUVy3dPVuDQmythv3iQRgG
 z5JNzfqq5gzPKNKx+ETcXnVVmWFg0M0nk6xPcU4PwFUpGJslodFBTbCjNEXknV4sa/2I
 3XddxIyGo4SfV0zZtjmqFNwopC5pXp7AJK4rJhci0NgGWh7wB56hrqRXd1gLjzYWBwyi
 connNIenMkvw72c5o8QlZYk6VAIuF0d6cRmUze4lf23aEFMqWIjQqYdcZK2d7ClFH2BQ
 JcQ3THTIMSFLkUn1Seh3cZJej2GRZR4APwPZ1W+HZlOMtGBM6vDw9WAXVU/nPBpvEr0s
 /bmQ==
X-Gm-Message-State: AFq9FYJc3xUOIdfsBjdskvLw6Fvw3XUiDsuwXuz0BBM5FSky0/2zOrpJ
 gQCFPQTMyqo6JPijD1Hew6QH0C7/WdqAa09jOVuNiEUGpsN5vyJW2T+PdopJov1gvos6zhtZVlT
 kzBfyetKbqbqoW9c4G1laQZkmBgQABhlO94w8KB1kZflUTtfLYTcFWxJxh/GIv/O/mw==
X-Gm-Gg: AYBFou0jpZZRATf+AL9tlos/Kp9eI4jYm4Zs2BdTk/MAv33Qn9NLbydqvWQXaujs14w
 ZfSRyTE1DwldzDZq3fZZ13qZG41VtkUQKzah+2ZlkqPi6UWhGTt6Fxs/wmjsSMxraaUypTnO+8Q
 V1lRaRA0PITaFKwaIfEt0G4L3hnhNCpH9kEHaWsHR/L7qYfW0Php7yBJsDvAeP6RpxKMNgpXcyS
 dEUjlg6IEAp4fJPXTJkBj5d9eZmJaF357DMSMwguMl07pm8A5lgIYbiFH69pyClZ/IvWfbAvNxZ
 IZoODeSZPj/oszbOy2Y0P6coysymuwG4d9FEuwrhZbitdFgxa3rE+9xNKF9ne4S6Dk3s0061iQ0
 +Hi8LU28PJxvBF9WDAEk2CIMWovYA9L91uMNax2qTLYcEzi3tL9xyo7Z29VCrC9lgZie/1u9K+K
 WGMeAU33Mfq4OXv/IHksyu
X-Received: by 2002:a05:693c:880c:10b0:35c:cd26:3066 with SMTP id
 5a478bee46e88-36a424655bcmr5295886eec.41.1793398128545; 
 Fri, 30 Oct 2026 15:08:48 -0700 (PDT)
X-Received: by 2002:a05:693c:880c:10b0:35c:cd26:3066 with SMTP id
 5a478bee46e88-36a424655bcmr5295866eec.41.1793398128093; 
 Fri, 30 Oct 2026 15:08:48 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a429467cdsm9965691eec.19.2026.10.30.15.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 15:08:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>, Anton Johansson <anjo@rev.ng>
Subject: [PATCH v3 3/8] target/hexagon: add per-CPU HMX configuration
Date: Fri, 30 Oct 2026 15:08:35 -0700
Message-Id: <20261030220840.4142885-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
References: <20261030220840.4142885-1-brian.cain@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfX2n5/ZOkCEy1A
 gNB/FOuwIGiHdpbilDs97CYgNH+R7M/Yb1QvEn0GFGKnwSw5bOlQDp25QQ7Z/NHYANGEKdbWD0P
 q9TbvnKI5bwMIRIipYpP/3UwhR67KiuhDtiSgddjzJxpo1xc6pft5jNwRdFVkhX/4TTCtygm1/O
 lAWMwPGYJDEznt7MIU+J3KKpcFEsM1l1PfN+wJ84gcKYJKBUAJGVtvCEZKr05suu2VEoYh6TYX6
 TVr5kLXjqpQS7FlLyJsaEDf2lrfs+hRKIgSEc7UIt7FkqQUpDFKn2PtPgw3s0aj1dZ0yFQJOjT1
 ubW1QfSCySN8BSGM8rLvgDBtwc9PVfrp7OEAaD8tZi0XIljx/9WEBW61mrEEvKw4L4vDxIoSNtW
 ZE4Z2bMw5zn0Tp5s8ptSV9x4QuvOG+EEQA3vlYQ2wW7dEtxfXIFeE2R8JoJmyB2Nb5nUY7q/ssZ
 X1tZASwh3bmbsVaDXPg==
X-Proofpoint-ORIG-GUID: 7BaJxBpc79n_jEv-IJ9amMEpVcB5QsP5
X-Proofpoint-GUID: 7BaJxBpc79n_jEv-IJ9amMEpVcB5QsP5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4OCBTYWx0ZWRfXx04owGjMws9W
 WC3Yni84zkUu4o1G5l1kGSIX6t4cioIFwicvk8G0bCKlIK6dZRl5qeBotJ/pTNsawqfR0y2Evtw
 Ip55jXJqhXY2vzqYHoWETqmmPPBbMso=
X-Authority-Analysis: v=2.4 cv=Arx7T+9P c=1 sm=1 tr=0 ts=6ae51571 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=yL6o_P92Z4u-jk1Vq6wA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_07,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300088
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

QWRkIEhteENvbmZpZyBhbmQgaG14X2luaXRfY29uZmlnKCksIHdoaWNoIGRlcml2ZSB0aGUgSE1Y
IGNvbmZpZ3VyYXRpb24KZnJvbSB0aGUgQ1BVIHJldmlzaW9uLgoKUmV2aWV3ZWQtYnk6IE1hcmNv
IExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdv
bi9jcHUuaCAgICAgICAgfCAgOCArKysrKysrKwogdGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5o
IHwgMTcgKysrKysrKysrKysrKysrKysKIGh3L2hleGFnb24vaGV4LXN1YnN5cy5jICAgICB8ICA3
ICsrKysrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICAgICB8IDIzICsrKysrKysrKysrKysr
KysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9obXhfY29uZmlnLmMgfCAxNSArKysrKysrKysrKysr
KysKIHRhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkICB8ICAxICsKIDYgZmlsZXMgY2hhbmdlZCwg
NzEgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2hteF9j
b25maWcuaAogY3JlYXRlIG1vZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2hteF9jb25maWcuYwoK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgK
aW5kZXggZmViODAzNjgyMzguLjIyYWExNjMwNzY3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdv
bi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtMzAsMTIgKzMwLDE1IEBACiB0
eXBlZGVmIHN0cnVjdCBIZXhhZ29uVExCU3RhdGUgSGV4YWdvblRMQlN0YXRlOwogdHlwZWRlZiBz
dHJ1Y3QgSGV4YWdvbkdsb2JhbFJlZ1N0YXRlIEhleGFnb25HbG9iYWxSZWdTdGF0ZTsKIHR5cGVk
ZWYgc3RydWN0IEhleGFnb25IVlhDb250ZXh0U3RhdGUgSGV4YWdvbkhWWENvbnRleHRTdGF0ZTsK
K3R5cGVkZWYgc3RydWN0IEhleGFnb25ITVhDb250ZXh0U3RhdGUgSGV4YWdvbkhNWENvbnRleHRT
dGF0ZTsKIAogI2luY2x1ZGUgImNwdS1xb20uaCIKICNpbmNsdWRlICJleGVjL2NwdS1jb21tb24u
aCIKICNpbmNsdWRlICJleGVjL3RhcmdldF9sb25nLmgiCiAjaW5jbHVkZSAiaGV4X3JlZ3MuaCIK
ICNpbmNsdWRlICJtbXZlYy9tbXZlYy5oIgorI2luY2x1ZGUgImhteF9jb25maWcuaCIKKyNpbmNs
dWRlICJobXhfc3RhdGUuaCIKICNpbmNsdWRlICJody9jb3JlL3JlZ2lzdGVyZmllbGRzLmgiCiAj
aW5jbHVkZSAicWVtdS9iaXRtYXAuaCIKIApAQCAtMTk3LDYgKzIwMCw4IEBAIHR5cGVkZWYgc3Ry
dWN0IENQVUFyY2hTdGF0ZSB7CiAgICAgdGFyZ2V0X3Vsb25nIHZzdG9yZV9wZW5kaW5nW1ZTVE9S
RVNfTUFYXTsKICAgICBib29sIHZ0Y21fcGVuZGluZzsKICAgICBWVENNU3RvcmVMb2cgdnRjbV9s
b2c7CisKKyAgICBIbXhTdGF0ZSAqaG14X3N0YXRlOwogfSBDUFVIZXhhZ29uU3RhdGU7CiAKIHR5
cGVkZWYgc3RydWN0IEhleGFnb25DUFVDbGFzcyB7CkBAIC0yMTcsMTIgKzIyMiwxNSBAQCBzdHJ1
Y3QgQXJjaENQVSB7CiAgICAgSGV4YWdvbkNQVUNvbmZpZyBjZmc7CiAjaWZuZGVmIENPTkZJR19V
U0VSX09OTFkKICAgICBIZXhhZ29uSFZYQ29udGV4dFN0YXRlICpodnhfY3R4W0hWWF9DT05URVhU
U19NQVhdOworICAgIEhleGFnb25ITVhDb250ZXh0U3RhdGUgKmhteF9jdHg7CiAgICAgSGV4YWdv
blRMQlN0YXRlICp0bGI7CiAgICAgdWludDMyX3QgYm9vdF9hZGRyOwogICAgIEhleGFnb25HbG9i
YWxSZWdTdGF0ZSAqZ2xvYmFscmVnczsKICAgICB1aW50MzJfdCBodGlkOwogICAgIEhleEwyVmlj
SW50ZXJmYWNlICpsMnZpYzsKICNlbmRpZgorICAgIEhteFN0YXRlICpobXg7CisgICAgSG14Q29u
ZmlnIGhteF9jZmc7CiB9OwogCiBzdGF0aWMgaW5saW5lIEhleGFnb25IVlhDb250ZXh0ICpoZXhf
aHZ4KENQVUhleGFnb25TdGF0ZSAqZW52KQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaG14
X2NvbmZpZy5oIGIvdGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5oCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0CmluZGV4IDAwMDAwMDAwMDAwLi5jYjE0MzNmNTRiOAotLS0gL2Rldi9udWxsCisrKyBiL3Rh
cmdldC9oZXhhZ29uL2hteF9jb25maWcuaApAQCAtMCwwICsxLDE3IEBACisvKgorICogQ29weXJp
Z2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5kL29yIGl0cyBzdWJzaWRpYXJp
ZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcgorICovCisK
KyNpZm5kZWYgSEVYQUdPTl9ITVhfQ09ORklHX0gKKyNkZWZpbmUgSEVYQUdPTl9ITVhfQ09ORklH
X0gKKworI2luY2x1ZGUgImNwdS1xb20uaCIKKwordHlwZWRlZiBzdHJ1Y3QgSG14Q29uZmlnIHsK
KyAgICBib29sIGhteF9wcmVzZW50OworfSBIbXhDb25maWc7CisKK3ZvaWQgaG14X2luaXRfY29u
ZmlnKEhleGFnb25DUFUgKmNwdSk7CisKKyNlbmRpZiAvKiBIRVhBR09OX0hNWF9DT05GSUdfSCAq
LwpkaWZmIC0tZ2l0IGEvaHcvaGV4YWdvbi9oZXgtc3Vic3lzLmMgYi9ody9oZXhhZ29uL2hleC1z
dWJzeXMuYwppbmRleCA0ZDlhNzljZmY3NC4uNWQyMjdjMGRiMmIgMTAwNjQ0Ci0tLSBhL2h3L2hl
eGFnb24vaGV4LXN1YnN5cy5jCisrKyBiL2h3L2hleGFnb24vaGV4LXN1YnN5cy5jCkBAIC0xODcs
NiArMTg3LDggQEAgdm9pZCBoZXhfc3Vic3lzX2NyZWF0ZShIZXhhZ29uQ29tbW9uTWFjaGluZVN0
YXRlICpobXMsCiAKIHZvaWQgaGV4X3N1YnN5c19hZGRfY3B1KEhleGFnb25Db21tb25NYWNoaW5l
U3RhdGUgKmhtcywgRGV2aWNlU3RhdGUgKmNwdSkKIHsKKyAgICBPYmplY3QgKmhteDsKKwogICAg
IG9iamVjdF9wcm9wZXJ0eV9hZGRfY2hpbGQoT0JKRUNUKGhtcy0+Y2x1c3RlciksICJjcHVbKl0i
LCBPQkpFQ1QoY3B1KSk7CiAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVChjcHUp
LCAiZ2xvYmFsLXJlZ3MiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QoaG1z
LT5nbG9iX3JlZ3MpLCAmZXJyb3JfZmF0YWwpOwpAQCAtMjAwLDYgKzIwMiwxMSBAQCB2b2lkIGhl
eF9zdWJzeXNfYWRkX2NwdShIZXhhZ29uQ29tbW9uTWFjaGluZVN0YXRlICpobXMsIERldmljZVN0
YXRlICpjcHUpCiAKICAgICAgICAgb2JqZWN0X3Byb3BlcnR5X3NldF9saW5rKE9CSkVDVChjcHUp
LCBuYW1lLCBjdHgsICZlcnJvcl9mYXRhbCk7CiAgICAgfQorICAgIGhteCA9IG9iamVjdF9yZXNv
bHZlX3BhdGhfY29tcG9uZW50KE9CSkVDVChobXMpLCAiaG14LWNvbnRleHQiKTsKKyAgICBpZiAo
aG14KSB7CisgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfbGluayhPQkpFQ1QoY3B1KSwgImht
eC1jb250ZXh0IiwgaG14LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJmVycm9y
X2ZhdGFsKTsKKyAgICB9CiB9CiAKIHZvaWQgaGV4X3N1YnN5c19yZWFsaXplX2NsdXN0ZXIoSGV4
YWdvbkNvbW1vbk1hY2hpbmVTdGF0ZSAqaG1zKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Y3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAyODFkMjAxMjUwYi4uODNlMjM3NzVl
YTIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L2NwdS5jCkBAIC00NSw2ICs0NSw3IEBACiAjaW5jbHVkZSAiZXhlYy90YXJnZXRfcGFnZS5oIgog
I2luY2x1ZGUgImh3L2hleGFnb24vaGV4YWdvbl9nbG9iYWxyZWcuaCIKICNpbmNsdWRlICJody9o
ZXhhZ29uL2hleGFnb25faHZ4X2NvbnRleHQuaCIKKyNpbmNsdWRlICJody9oZXhhZ29uL2hleGFn
b25faG14X2NvbnRleHQuaCIKICNlbmRpZgogCiBzdGF0aWMgT2JqZWN0Q2xhc3MgKmhleGFnb25f
Y3B1X2NsYXNzX2J5X25hbWUoY29uc3QgY2hhciAqY3B1X21vZGVsKQpAQCAtNTM5LDYgKzU0MCwy
NCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVy
cm9yICoqZXJycCkKIAogICAgIGNwdS0+Y2ZnLmhleF9kZWYgPSBtY2MtPmhleF9kZWY7CiAKKyAg
ICBobXhfaW5pdF9jb25maWcoY3B1KTsKKyNpZmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgLyog
QWxsIHRocmVhZHMgb2YgdGhlIHByb2Nlc3Mgc2hhcmUgb25lIEhNWCB1bml0ICovCisgICAgc3Rh
dGljIEhteFN0YXRlICp1c2VyX2hteDsKKworICAgIGlmIChjcHUtPmhteF9jZmcuaG14X3ByZXNl
bnQpIHsKKyAgICAgICAgaWYgKCF1c2VyX2hteCkgeworICAgICAgICAgICAgdXNlcl9obXggPSBn
X25ldzAoSG14U3RhdGUsIDEpOworICAgICAgICB9CisgICAgICAgIGNwdS0+aG14ID0gdXNlcl9o
bXg7CisgICAgfQorI2Vsc2UKKyAgICBpZiAoY3B1LT5obXhfY3R4ICYmIGNwdS0+aG14X2NmZy5o
bXhfcHJlc2VudCkgeworICAgICAgICBjcHUtPmhteCA9ICZjcHUtPmhteF9jdHgtPnJlZ3M7Cisg
ICAgfQorI2VuZGlmCisgICAgY3B1X2VudihjcyktPmhteF9zdGF0ZSA9IGNwdS0+aG14OworCiAg
ICAgZ2RiX3JlZ2lzdGVyX2NvcHJvY2Vzc29yKGNzLCBoZXhhZ29uX2h2eF9nZGJfcmVhZF9yZWdp
c3RlciwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaGV4YWdvbl9odnhfZ2RiX3dyaXRl
X3JlZ2lzdGVyLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnZGJfZmluZF9zdGF0aWNf
ZmVhdHVyZSgiaGV4YWdvbi1odngueG1sIikpOwpAQCAtNjI5LDYgKzY0OCwxMCBAQCBzdGF0aWMg
dm9pZCBoZXhhZ29uX2NwdV9pbml0KE9iamVjdCAqb2JqKQogICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgcWRldl9wcm9wX2FsbG93X3NldF9saW5rX2JlZm9yZV9yZWFsaXplLAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKX1BST1BfTElOS19TVFJPTkcpOwogICAg
IH0KKyAgICBvYmplY3RfcHJvcGVydHlfYWRkX2xpbmsob2JqLCAiaG14LWNvbnRleHQiLCBUWVBF
X0hFWEFHT05fSE1YX0NPTlRFWFQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChPYmpl
Y3QgKiopJmNwdS0+aG14X2N0eCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcWRldl9w
cm9wX2FsbG93X3NldF9saW5rX2JlZm9yZV9yZWFsaXplLAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBPQkpfUFJPUF9MSU5LX1NUUk9ORyk7CiAjZW5kaWYKIH0KIApkaWZmIC0tZ2l0IGEv
dGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5jIGIvdGFyZ2V0L2hleGFnb24vaG14X2NvbmZpZy5j
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi41ZGNjNzAwOWE5NQotLS0g
L2Rldi9udWxsCisrKyBiL3RhcmdldC9oZXhhZ29uL2hteF9jb25maWcuYwpAQCAtMCwwICsxLDE1
IEBACisvKgorICogQ29weXJpZ2h0IChjKSBRdWFsY29tbSBUZWNobm9sb2dpZXMsIEluYy4gYW5k
L29yIGl0cyBzdWJzaWRpYXJpZXMuCisgKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIu
MC1vci1sYXRlcgorICovCisKKyNpbmNsdWRlICJxZW11L29zZGVwLmgiCisjaW5jbHVkZSAiY3B1
LmgiCisjaW5jbHVkZSAiaG14X2NvbmZpZy5oIgorCit2b2lkIGhteF9pbml0X2NvbmZpZyhIZXhh
Z29uQ1BVICpjcHUpCit7CisgICAgSGV4YWdvblZlcnNpb24gdmVyID0gY3B1LT5jZmcuaGV4X2Rl
Zi0+aGV4X3ZlcnNpb247CisKKyAgICBjcHUtPmhteF9jZmcuaG14X3ByZXNlbnQgPSB2ZXIgPj0g
SEVYX1ZFUl9WNjg7Cit9CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tZXNvbi5idWlsZCBi
L3RhcmdldC9oZXhhZ29uL21lc29uLmJ1aWxkCmluZGV4IDA2MzM4NTIzMjE3Li5mZTMyMDZlZjhi
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQKKysrIGIvdGFyZ2V0L2hl
eGFnb24vbWVzb24uYnVpbGQKQEAgLTI1NCw2ICsyNTQsNyBAQCBoZXhhZ29uX3NzLmFkZChmaWxl
cygKICAgICAnbW12ZWMvc3lzdGVtX2V4dF9tbXZlYy5jJywKICAgICAnbW12ZWMvaHZ4X2llZWVf
ZnAuYycsCiAgICAgJ21tdmVjL2h2eF9xZmxvYXQuYycsCisgICAgJ2hteF9jb25maWcuYycsCiAp
KQogCiBoZXhhZ29uX3NvZnRtbXVfc3MuYWRkKGZpbGVzKAotLSAKMi4zNC4xCgo=

