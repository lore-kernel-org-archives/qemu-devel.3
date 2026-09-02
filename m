Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3FEC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:46:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1cox-0000gj-4V; Wed, 02 Sep 2026 00:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cov-0000f9-KK
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cot-0000QG-K9
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:33 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6824M1W12982864
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mqNoeHtdFOV/gb6ZNLRhsaJUt3UTdl0o5mgBjZ7nPM0=; b=KtkXiSNgft7x6kRB
 v20oXC932JSoYzDgc8qvuYPeBV7oCy21BjjunbhqbYDKGL8dzRvVK4ettMKP/NqR
 mbHb9mm3xo8oS799vWA4stoWcqifZ/TGyv2W8OdP6t0fKUcHlyEPjfdO/7NTFB8i
 supYOxSrxPlZjgzHyNDK3+JLVEv95DnYJkWMolcYm754BxRfRhBSt3OG1USyGXYZ
 ZDoxz/ct4/K84IbKQ2y4kcYCt+v2wlBn4h1evXgL/t+g3kXExPlUr7CbBhLReHZa
 2wcvhNZ09zpMLtA9btW/eBA8yZ+KRRIPzwzdMX1mKX5w6xhxZEQ4PnWV80XnChEB
 wzJG5w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge35k25ua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:19 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d55d8cd938so10355725ad.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324199; x=1788928999; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mqNoeHtdFOV/gb6ZNLRhsaJUt3UTdl0o5mgBjZ7nPM0=;
 b=ZtlMvIUq5ULcIbDNQb9RaSwkU+x+ng3bDQlk2R3YxMyaLV896i3sKwD8UX5wNX6R7V
 t0ET43kldeASFprJhnV+2bW7j0Fo/giPLCgY7DQcVbu385uhemqnlNpJYxxhqvVSg2cK
 KB6+XZC2qo56uhQOVL+v/T9p43AQlt+jy3pwm3MQyKZ76tQg8bcTPcJzPffbA1kUJ7uE
 89E32m6TbNQbEgXyyj9lNM6YEOrQtLpxDZUKti12RZZjtmD1qiUMM82w8Rok5IAbXegR
 xZqm5aOiY6bY8tufak3IG4qIM0xKwwIlf71imGHYVRcclBx5aMlgGkbH528XJ1WP2csw
 olfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324199; x=1788928999;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mqNoeHtdFOV/gb6ZNLRhsaJUt3UTdl0o5mgBjZ7nPM0=;
 b=o8rO5JGGiZvA9XgNfklHbP4f/uAZcmq4ETaKHioFSQ3VryqoctojAFNuJa4vYwXqBb
 CbLdqxtFodEw+CTmowoTfZvnpzndwLF37ZfVKnmqJbB971RCQP61getTkRrQNBb40MZL
 i3OCIoh1LoxKwSfku/SPLqIziC3PVqTyymlISKc0yIoetrfyM+3Hvatz/7sMdFp2WzFo
 NejR78kkQ/Xu8MqQsqhWxS20G619BoYPALTn+85FZ898Dj7ATxHhut4d710QbXrFOIvV
 IxTFek5ZzcZwU2ZdmDTOlDtBt6aHCi5GFvadVtKq2NK7MaDpA+6mv2vHR4EjgbbbVKNQ
 VL6w==
X-Gm-Message-State: AFuF++kwsHl6hZG1MUN1JlBlnupQRiFjCrgG5y6K1/GUBffjWFusLroT
 QCgGw/cXZkAGPCsbYawJdQCOmh/CiFNlUDskk6pgCmzel6EBFM2rxNN+0KNwuuI8cFj8Bnb4Ddk
 oabzeq02GW0Is2YQ9t0GsU7B1hBknnNSJo7fvw5I71LcDXuiDv1I6+siA6pE97uIgDA==
X-Gm-Gg: AYBFou1W33ihW1tB4WKS6Reic+5QRhK/2TrJJE3yqSgk3Zv3Mun8y2IUy7qOMLns61c
 b5qYwtlOqiATkrdpaQKHyMrr4EVd4BzJX31EM4GyUZAq+Yq0+5TVY75Chyiu8LI2tZq1i6UB/ey
 9Da2bNTjlr37V/foKiSFc95bO5VgJVWubXObgtMnXn02v0ASgiBUsDYL7uKRNGbI1UESX+edKeM
 tKzgKW5v3Ay93Tfxm98jNbw7p/oMlaa23727QqmWrY/1N+SFWU2nDTzEpxquYStYxtNOVt++yJD
 u11l0wgiwHQbdhoRc+DFsl2CcAExaFDvqCvuM66fgTSeZVp0p8aP3NLIA+rzHbT/wlATEuXWowl
 QputLFTj9jstrsIEnQEXbuvKKDIkXQ1Do3ObAanwjkmlQrxgr
X-Received: by 2002:a17:903:2383:b0:2d9:51db:7eaa with SMTP id
 d9443c01a7336-2daec741025mr35898095ad.20.1788324199422; 
 Tue, 01 Sep 2026 21:43:19 -0700 (PDT)
X-Received: by 2002:a17:903:2383:b0:2d9:51db:7eaa with SMTP id
 d9443c01a7336-2daec741025mr35897515ad.20.1788324198977; 
 Tue, 01 Sep 2026 21:43:18 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:16 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 24/28] tests/functional/hexagon: update to v0.2.12,
 +test_{interrupts, sys_regs}
Date: Tue,  1 Sep 2026 21:42:27 -0700
Message-Id: <20260902044231.843004-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX4SXMa5JJdp7N
 0fkvHER883LDvvZAsnW2pdGMZZ5rmiwAarce1SnMWQsWoQA9Ts2VW9t+KN++ShV72pmguZ12xjZ
 QwWvOYwr2CouYq7Vo4el6XbCX2LdS7ouovwYj/5MeBuuJPicHaSZR8dXqPbdqmj/SbpbAo4ADhN
 F0GoHmPUFlB/x+7vxLHnrVQxImGHsPqhdDqqNvHO+yFxH+D2qNs15MqFAKzq+/ECdBC0lPWoPII
 mYZkenRX9QvbddR20UuvUadkPAmc10hsv3ATaPdAhoqfSwERHzaLyta2twX1EfaicWwL4SogRkG
 QA1lN3ZDLrvjfbWMGBdjhfQAjLYBiShamvZKFLZpBdyzykxOTmw1i1BzwTkkc4iQrWQI0FGEO4/
 vY+ShwNkvAtYbyVSdxm6A71TPHF80QgLbohBlyZbqa3KHbyxn9x870x6mG4AajTGg5ju6sjucj4
 LGuUqpfUIAZcUzBXQeg==
X-Proofpoint-GUID: DzUl-exWMCQD0p4Sih0OeIG0dx4J4PWv
X-Proofpoint-ORIG-GUID: DzUl-exWMCQD0p4Sih0OeIG0dx4J4PWv
X-Authority-Analysis: v=2.4 cv=VLrtWdPX c=1 sm=1 tr=0 ts=6a97a968 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=5vFef2XoAAAA:20 a=EUspDBNiAAAA:8 a=zjiCbJeFjdgwON9hqt0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX/KipI9NQllsS
 8JhEm/Wkc5+piex4IDzxhVPB4BIKH3EEjPI6G7ABVBUJ0zPgnTuf4T/rjZL6tfK3PJAp2xYfnEM
 0RvqzgOKqwUBFtn1cWYKmyPddKTsSmI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
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

dGVzdF9pbnRlcnJ1cHRzIGFsc28gbm93IHBhc3NlcyBpbiBmdWxsIGZvbGxvd2luZyB0aGUgaWFz
c2lnbntyLHd9CmZpeCwgc28gZW5hYmxlIGl0IGFsb25nc2lkZSB0aGUgb3RoZXIgYXJjaCB0ZXN0
cy4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5x
dWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1
YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVzdF9hcmNoX3Rlc3Rz
LnB5IHwgMTIgKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90ZXN0cy9mdW5jdGlvbmFsL2hleGFnb24vdGVz
dF9hcmNoX3Rlc3RzLnB5IGIvdGVzdHMvZnVuY3Rpb25hbC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0
cy5weQppbmRleCAwODM0Mzk4YzNiMS4uOGU3MTM4NmMxODYgMTAwNzU1Ci0tLSBhL3Rlc3RzL2Z1
bmN0aW9uYWwvaGV4YWdvbi90ZXN0X2FyY2hfdGVzdHMucHkKKysrIGIvdGVzdHMvZnVuY3Rpb25h
bC9oZXhhZ29uL3Rlc3RfYXJjaF90ZXN0cy5weQpAQCAtMjEsOCArMjEsOCBAQCBjbGFzcyBBcmNo
VGVzdHNVYXJ0KFFlbXVTeXN0ZW1UZXN0KToKIAogICAgIEFTU0VUX1RBUkJBTEwgPSBBc3NldCgK
ICAgICAgICAgImh0dHBzOi8vZ2l0aHViLmNvbS9xdWFsY29tbS9xZW11LWhleGFnb24tdGVzdGlu
Zy9yZWxlYXNlcy8iCi0gICAgICAgICJkb3dubG9hZC92MC4yLjUvYXJjaF90ZXN0c191YXJ0LnRh
ci5neiIsCi0gICAgICAgICJlZGI0ZjM3Yjg3N2EzYTcyYTBlMTA5MjA0Nzc0NThhNDNiNDAwNDVk
MzQzOThmZWU4Y2I3NjNmZWZkMzQyZjRmIiwKKyAgICAgICAgImRvd25sb2FkL3YwLjIuMTIvYXJj
aF90ZXN0c191YXJ0LnRhci5neiIsCisgICAgICAgICI4NzFhMzM5YmY3OGNhYzBlYmFmMWIyNTA5
YmZjZDViMjQ5YWQ4MTkwYmUzM2UwY2Y4NDgyODNiMmY2OTE1MzIzIiwKICAgICApCiAKICAgICBk
ZWYgcnVuX3VhcnRfdGVzdChzZWxmLCB0ZXN0X25hbWU6IHN0ciwKQEAgLTU4LDYgKzU4LDEwIEBA
IGRlZiB0ZXN0X2ludF9zdGVlcmluZyhzZWxmKSAtPiBOb25lOgogICAgICAgICAiIiIKICAgICAg
ICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2ludF9zdGVlcmluZyIpCiAKKyAgICBkZWYgdGVz
dF9pbnRlcnJ1cHRzKHNlbGYpIC0+IE5vbmU6CisgICAgICAgICIiIlRlc3RzIGludGVycnVwdCBk
ZWxpdmVyeS4iIiIKKyAgICAgICAgc2VsZi5ydW5fdWFydF90ZXN0KCJ0ZXN0X2ludGVycnVwdHMi
KQorCiAgICAgZGVmIHRlc3RfY2FjaGUoc2VsZikgLT4gTm9uZToKICAgICAgICAgIiIiVGVzdHMg
Y2FjaGUgb3BlcmF0aW9uczogZGNraWxsL2lja2lsbCwgbDJraWxsLCBkY3plcm9hLAogICAgICAg
ICBkY2NsZWFuaW52YSwgY2FjaGUgZGlzYWJsZS9lbmFibGUsIGJhcnJpZXJzLCBhbmQgZGNpbnZh
L2RjY2xlYW5hLgpAQCAtNzAsNiArNzQsMTAgQEAgZGVmIHRlc3RfbDJ2aWMoc2VsZikgLT4gTm9u
ZToKICAgICAgICAgIiIiCiAgICAgICAgIHNlbGYucnVuX3VhcnRfdGVzdCgidGVzdF9sMnZpYyIp
CiAKKyAgICBkZWYgdGVzdF9zeXNfcmVncyhzZWxmKSAtPiBOb25lOgorICAgICAgICAiIiJUZXN0
cyBzeXN0ZW0gcmVnaXN0ZXJzLiIiIgorICAgICAgICBzZWxmLnJ1bl91YXJ0X3Rlc3QoInRlc3Rf
c3lzX3JlZ3MiKQorCiAgICAgZGVmIHRlc3RfdGhyZWFkcyhzZWxmKSAtPiBOb25lOgogICAgICAg
ICAiIiJUZXN0cyBoYXJkd2FyZSB0aHJlYWQgbWFuYWdlbWVudDogc3RhcnQvc3RvcCwgTU9ERUNU
TCBzdGF0ZSwKICAgICAgICAgcGVyLXRocmVhZCBIVElELCBzaGFyZWQgbWVtb3J5LCB3YWl0L3Jl
c3VtZSwgU1RJRCBwcmlvcml0eSwgYW5kCi0tIAoyLjM0LjEKCg==

