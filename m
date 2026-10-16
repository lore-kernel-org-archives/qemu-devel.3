Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB5FCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 14:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHiwz-0004oQ-NE; Fri, 16 Oct 2026 10:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHiww-0004nS-Tv
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:30:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xHiwu-0007eX-Jx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 10:30:22 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GE6Ldi2494819
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 14:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Enf2W/dFQxa7P2tBTeMCV59yWp+gzwwLwHLrsTYW8WY=; b=mcxSFmquqwAIbuP6
 QiTAykyAc0mBsLDXpPYwFnnfjkoFLcr11X+UdM5pZtyVeX/PEdd+QaDiBpnQUDJI
 yHEGfT5f92sPoGT54ZIKHQgSnoKpIb/ygaDqJjBaFwbQ+5z6Gp6eIx3rjCAT90Sk
 oAUI0FFLIHF0OwU87b8dhDNLvE7XyYr/YwIbkQIPRtpEzWeB1SkBF70nxwRMXMY9
 T2XQdfGKP71tg+5gaGSvsUilZE8cp2FuZpgdGId/dk5hq7dIX0kpdDPg3i2rq+Bm
 eg2Bc7rQN2utSBNAlVC8ZnYMKTJzzMKV+oIzA7OGFxOAAfdNa36XCzSCM8QIslco
 ZK4Tnw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8a8b1vu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 14:30:18 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id
 71dfb90a1353d-5e944179148so2759039e0c.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 07:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792161017; x=1792765817; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Enf2W/dFQxa7P2tBTeMCV59yWp+gzwwLwHLrsTYW8WY=;
 b=EMjSUllE5GTTc4PwLTtZhSqYzGM7OIK4YqqKrk18V7S0Eb14vN71FHEFPQShmV14hq
 Uhot9gU+OLIGlHXwNODPYgYKaUTiRpcM6heMsyD8Ay4dpd6eEd/SoZLS7BmlS5uM+C63
 KOaXUVLI5YFYIUfos2a3YUN15XiYGOiQbsx968R3bEm+OotHFEXYNyE3y2HEqSUdiNOs
 eVryTg/MQd3MU7A15rqxw/jvbdsXR0VsqspsE1X15EQlJdKCfxx/3GAkRijZWVkgRXVJ
 rKq8ZRL6dG6bJv6hF98b7hBhMyreAkNc6D8r6ypGITPsqNtiU//rnpZmWeN/xFYu9L8U
 f3Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792161017; x=1792765817;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Enf2W/dFQxa7P2tBTeMCV59yWp+gzwwLwHLrsTYW8WY=;
 b=jd4POYq9oWj9vtGqtqz6Y67xniiLGSjYtRYDEjb7Ul0d6c2QygWeY42hXaCsHiUlAb
 4+B6S8MXY2djIhzfiNzuWf4YPDvypFKRcBxxF3qzUmRCSvLX0K+D8k97Y1FIyuuKcB7k
 eU2QDR7INZK23fCHnwkCGv6bj0mAyLWOZ8BEW3w278BaoCAR9oYdeaO7qipipB7/99Sp
 WsmSBq4Qie9pQOmEru4aNUPoBFlR+JX4upLTwtrG9oKpar9006d9IgI0xLMtRDIMKkq/
 Bq1UujR3Q+9+mm1DmcKg7b5V7P8jQDq9PxBSgBo2fMT9ntolncAkw01Lc1YHWgpGXpl9
 QaEQ==
X-Gm-Message-State: AFq9FYJIfqhH2gJ+GNqlCgfvs30+427c5s9cYJL/xqrcUc9qorDESGKG
 Nf1+gQBHHCQeuuij+uQLaZrTFvzZLywp38QkYq5VBVSIxmoHLf9eE4dJFSDJTB2AA/v9uWTGRPG
 QqvpOPj8tqpUqJ4zWa02jtWNIRMWM7SZxG659H3iyUjKNfEl98vgDFjqOmsYPmBylVQ==
X-Gm-Gg: AYBFou1cq3qVr3X7EhGKyndCDf8WGhOS1BH23sWmqRPhvfWTxnLdIlonjLGr/yyFky4
 ZeXE2crkpVqllwigynBAkW8vkdi7NNZvHPxTSzVKoRuelUbLUqbCz1YYflfGaPkFsuxQs+ZHNab
 vhNLyowVFzV3lMhpPEcZI7sr6ZwYi14JFgzBElz1lxWnSkPdBkJ+f3h5/sYeWqNfM5lG8g+7ghI
 5/Q8lBmDR19VSlPThmW0ugs+G6A9OFWDvSVzvvmO9LahpJN1E6h1zZali/PcE04l6rhgqQKb3xb
 NSPtPH696zVhuN9fqckW0Lxny/qjEzAuh/Rd3Lud/iQkgSvi0guYF4Z7seXB6npCmcgf2uDMV6j
 7kzqQD15eLE1HSBFAsdIuQWudJQR5fGR5Ri58wem4m7sqNtA=
X-Received: by 2002:a05:6122:1d8d:b0:5e9:7c82:9a05 with SMTP id
 71dfb90a1353d-5eaaa409045mr104657e0c.9.1792161016952; 
 Fri, 16 Oct 2026 07:30:16 -0700 (PDT)
X-Received: by 2002:a05:6122:1d8d:b0:5e9:7c82:9a05 with SMTP id
 71dfb90a1353d-5eaaa409045mr104631e0c.9.1792161016174; 
 Fri, 16 Oct 2026 07:30:16 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ea9b474b2asm1605214e0c.4.2026.10.16.07.30.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 07:30:15 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: philmd@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 peter.maydell@linaro.org, Brian Cain <brian.cain@oss.qualcomm.com>
Subject: [PATCH v4 3/4] target/hexagon: fix semihosting STAT filename handling
Date: Fri, 16 Oct 2026 07:30:06 -0700
Message-Id: <20261016143007.3474704-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016143007.3474704-1-brian.cain@oss.qualcomm.com>
References: <20261016143007.3474704-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfXws9RON+QFGTe
 6uIcp+zfKOhOt74qObunCNRBtoxsDXZYYjT9zoOPdvQCKq9PsT5vDP5WxNGlIl9dYuJ7CZv56q5
 BP6Xt1yh82s7y+wmmqt/ecsUmrLJSqU=
X-Proofpoint-ORIG-GUID: UiUYK2faIdnDFFRJlot-2kscf4trHvC8
X-Authority-Analysis: v=2.4 cv=GJadgeNK c=1 sm=1 tr=0 ts=6ad234fa cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=FZZFJ5KotruyPtQxbZcA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NyBTYWx0ZWRfX9pxXE+vQzxTf
 1EQwTlQYBM4jRVRxCnFSLnCegPDemQBUL8Y9a/V06nuCdYIk/jS5yt5GRTyS0QHW842yNM1L7Tj
 EKjSdqzXlBjlb3tAifMvYRsiMiYWCAIszYNCbtXWwajVCyukzp2I2DNjRMlWpMLfcoRcDk1vUKV
 mZYSNuaHV3n83y8c3gt9qX50hTgS4InriuyT/jSO6/duVqt+fZ1qnkU+fHvGm1zRM1VqAaSLiTL
 qwp2Vd9yfdz8LZICs/ckmDx6Tx917KXwGPt4r7FI9cYEv9ITUQVdcQ1zAuBU1qmMibp9hjD970S
 PkBZkD1680N1nDas4aiXYo63BTFTKa5KjqULy3QDir/lHuDW3OZNlcn5k5MgE4N25xZEBE0X9uR
 Qdt7lYPLK3KgbOjMCD41PPbp1NJdaGcdIe5R9/pjvqSqDvTm8W67hIC/nKoR4e+Si7p2IyfKyzO
 x9ZGc3CZKgpYpws0wiA==
X-Proofpoint-GUID: UiUYK2faIdnDFFRJlot-2kscf4trHvC8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160057
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

SEVYX1NZU19TVEFUIGNvdWxkIHBhc3MgYW4gdW50ZXJtaW5hdGVkIGxvY2FsIGZpbGVuYW1lIGJ1
ZmZlciB0byBzdGF0KCkKd2hlbiB0aGUgZ3Vlc3Qgc3RyaW5nIGZpbGxlZCBpdC4gVXNlIGxvY2tf
dXNlcl9zdHJpbmcoKSB0byBtYXAgdGhlIGd1ZXN0CnN0cmluZyBzYWZlbHkuCgpGaXhlczogNzcx
MWZkYmE4OGIgKCJ0YXJnZXQvaGV4YWdvbjogYWRkIG1haW4gYXJjaC1zcGVjaWZpYyBzZW1paG9z
dGluZyBvcGVyYXRpb25zIikKTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBRkVB
Y0E5TU9zNlZmSGYyVUhaOHo0Y2R2YUIrN0RZNmhKYjJlbVlaMmFMU2UtdDZpd0BtYWlsLmdtYWls
LmNvbS8KU3VnZ2VzdGVkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5v
cmc+ClJldmlld2VkLWJ5OiBQZXRlciBNYXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyB8IDE1ICsrKysrKystLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90
YXJnZXQvaGV4YWdvbi9oZXhzd2kuYyBiL3RhcmdldC9oZXhhZ29uL2hleHN3aS5jCmluZGV4IGNj
NDhjOWJhOWYxLi5hNWM4ZWUyN2M3ZSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4c3dp
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vaGV4c3dpLmMKQEAgLTU2NCw3ICs1NjQsNyBAQCBzdGF0
aWMgdm9pZCBzaW1faGFuZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICBz
dHJ1Y3Qgc3RhdCBzdF9idWY7CiAgICAgICAgIHVpbnQ4X3QgKnN0X2J1ZnB0ciA9ICh1aW50OF90
ICopJnN5c19zdGF0OwogICAgICAgICBpbnQgcmMsIGVyciA9IDA7Ci0gICAgICAgIGNoYXIgZmls
ZW5hbWVbQlVGU0laXTsKKyAgICAgICAgY2hhciAqZmlsZW5hbWU7CiAgICAgICAgIHRhcmdldF91
bG9uZyBwaHlzaWNhbF9maWxlbmFtZV9hZGRyOwogICAgICAgICB0YXJnZXRfdWxvbmcgc3RhdEJ1
ZmZlckFkZHI7CiAgICAgICAgIGlmIChnZXRfdXNlcl91MzIocGh5c2ljYWxfZmlsZW5hbWVfYWRk
ciwgc3dpX2luZm8pIHx8CkBAIC01NzMsMTUgKzU3MywxNCBAQCBzdGF0aWMgdm9pZCBzaW1faGFu
ZGxlX3RyYXAwKENQVUhleGFnb25TdGF0ZSAqZW52KQogICAgICAgICB9CiAKICAgICAgICAgaWYg
KHdoYXRfc3dpID09IEhFWF9TWVNfU1RBVCkgewotICAgICAgICAgICAgaW50IGkgPSAwOwotICAg
ICAgICAgICAgZG8gewotICAgICAgICAgICAgICAgIGlmIChnZXRfdXNlcl91OChmaWxlbmFtZVtp
XSwgcGh5c2ljYWxfZmlsZW5hbWVfYWRkciArIGkpKSB7Ci0gICAgICAgICAgICAgICAgICAgIGdv
dG8gZG9fZmF1bHQ7Ci0gICAgICAgICAgICAgICAgfQotICAgICAgICAgICAgICAgIGkrKzsKLSAg
ICAgICAgICAgIH0gd2hpbGUgKChpIDwgQlVGU0laKSAmJiBmaWxlbmFtZVtpIC0gMV0pOworICAg
ICAgICAgICAgZmlsZW5hbWUgPSBsb2NrX3VzZXJfc3RyaW5nKHBoeXNpY2FsX2ZpbGVuYW1lX2Fk
ZHIpOworICAgICAgICAgICAgaWYgKCFmaWxlbmFtZSkgeworICAgICAgICAgICAgICAgIHNlbWlf
Y2IoY3MsIC0xLCBFRkFVTFQpOworICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAg
fQogICAgICAgICAgICAgcmMgPSBzdGF0KGZpbGVuYW1lLCAmc3RfYnVmKTsKICAgICAgICAgICAg
IGVyciA9IGVycm5vOworICAgICAgICAgICAgdW5sb2NrX3VzZXIoZmlsZW5hbWUsIHBoeXNpY2Fs
X2ZpbGVuYW1lX2FkZHIsIDApOwogICAgICAgICB9IGVsc2UgewogICAgICAgICAgICAgaW50IGZk
ID0gcGh5c2ljYWxfZmlsZW5hbWVfYWRkcjsKICAgICAgICAgICAgIEd1ZXN0RkQgKmdmID0gZ2V0
X2d1ZXN0ZmQoZmQpOwotLSAKMi4zNC4xCgo=

