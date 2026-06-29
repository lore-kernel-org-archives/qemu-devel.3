Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81CE2C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:35:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3en-0005Fh-Fy; Mon, 29 Jun 2026 00:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3dq-000356-GD
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we3do-0001cP-Qy
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 00:30:42 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T4NTRv1777377
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=6Wt5EJgewH9h32VqnTvpeUdkce3hlYMJmq6TBx1dEGg=; b=Ez
 QGniSR6VsE0JuKKC0hBq17HaFCoOs1bqG666oHO3oU0BjkgHdCoj4qvgC5ts25SM
 op7pvx1HTWfkGZVFAvUsw1yZcZXYelPmQ0cHwYYMtlK4VhgSp4nUPAIpQf2PrFr0
 0IcTvkd8lmjVUND5R5TDm2D+w+LgdG50Y34sHRdiNrIYMWGrNEwfC73RXWKHf8TR
 lY/iUu0GD2+5AXIZocVqFmfahjd9Wj5oJCJHZaNBPYwQPU2/mTdZK2i3Gh0+p840
 HrLYuCqbQYLutMXCclm7e/3QunBM+qweeI5e0DgY2Y3MVZ0p0LiFhXVGEzZwn7KE
 vegVNodbzreaxwItGbBQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26x8mga4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 04:30:29 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c42d96713so1771264eec.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 21:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782707429; x=1783312229; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Wt5EJgewH9h32VqnTvpeUdkce3hlYMJmq6TBx1dEGg=;
 b=jFawMbclTkagjkY6vInKKtex3Uv2ir2fOSIkOrfAzMZmCSAaK1kaKFFY7CpiduXfqy
 +5B986ytOASIkrOgyE1EWPI7S6//jcsyy0Ff+XB5mhTV9N7V3M6tFSO8BWbH91CB3CQh
 6V7MpKqyAiUui55lsTMr+k71+fE+yCiIobdIqUDuwzRli2Fap5jtCNoH6acrr0AHPfzH
 mgggAU2AGIpdSDEVre96Vf/AO9d82xmMQ0dASQR/rgNHFRVvUMcHeV05sCfOhzrv1565
 m7H1LX+c8X8V8TXzizk9zqnfFaOPxofh5Y2Qy5Cn5sITXtydHa2U6u7C6uWaDMOpGQnN
 UYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782707429; x=1783312229;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6Wt5EJgewH9h32VqnTvpeUdkce3hlYMJmq6TBx1dEGg=;
 b=EdZs2h93Up4lRgD1Lnn5Dxiqa0sI7itE9dSfkgKMtZy7ZO2yGk0bYqTBgj7hAb6ArD
 7qttICh/aTuBQN8Ve7jJy3vY0GCKal3AL9YRUqiVQ1OthcxCaCSLqrDNV96jabdj3HkG
 rYYe13l5dJ7S1EeIQ4fvU31nDSVEIX1URO0hOYY9FKN73ctQNvKtV9Kx8yMvoFt128/i
 rcTbsVk2nSrAxN9b4njgHniUXZw7GPgwBIWEQ4oXUK9o5ERXd5VgbMrU9bwAwLV3K9Bk
 qliwngdb86H6fPC88MZUbF4ofQALo4qrAhLBUmmPAbDt/Ol37kVQXeF5e3SjRxOpDAPA
 q1xQ==
X-Gm-Message-State: AOJu0YxovnFdLI8pwAAffHTDrsEyvU/x26A3lUr1Gv2GlfYHmHVCe9z5
 YAf1aEjVRDoO+TYD2ilqNgi1uqNLwLzobIbu57GMjzyduWbnq5dfCyA0vBL6wSdjivEKUqlX5U3
 kWjE0lVjBMht+MIlg2O1oLvg3k7mmN5XQI/yFj3dHtolArjLIw9QriGgKHQrH7FNLTg==
X-Gm-Gg: AfdE7cnCuiVE4Fllf8ZrCcNXurYBT0c6G/u0mQN+FQiE/UGOOXraxJ6dWEM43tepmrm
 tsKE5ZwOitCTXKMluq1iUGYtkEMaav+TTRBj47EwrxY2FamCw+tg94QV8Qg6BcI8vGrHkoMciz1
 gd68UttnU9VZ+Ua0hETdWf4Ghkf5QZLZeq19pXW0S64H4akpJzisq8isu7O1Yzq5R2U13EweQ/l
 x/BkQNs/yThG6COg/XF4WVxZExrAU6XCcE1tFBpIHoWFNHTn4v3RcAxkKgafnaZolYFFkGI1fgB
 UqMelBstrKxitlgbwc+JIDk0ytARPunL3XketmX80YTfLzmIxVbt70soVFr+m95XN6brXAEh7Sv
 fAPXohf6KY+p6Pi5rFDKp0RAzdQesW6Sd8RKtVqcr2Hby75eWuluJGNUO87c=
X-Received: by 2002:a05:7300:4316:b0:2f2:6dde:df66 with SMTP id
 5a478bee46e88-30c84f3ed92mr17448822eec.22.1782707428830; 
 Sun, 28 Jun 2026 21:30:28 -0700 (PDT)
X-Received: by 2002:a05:7300:4316:b0:2f2:6dde:df66 with SMTP id
 5a478bee46e88-30c84f3ed92mr17448796eec.22.1782707428228; 
 Sun, 28 Jun 2026 21:30:28 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30d3af0d2e4sm21314609eec.22.2026.06.28.21.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 21:30:27 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v4 77/77] tests/qtest: Add hexagon boot-serial-test
Date: Sun, 28 Jun 2026 20:58:30 -0700
Message-Id: <20260629035830.1520296-78-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfX31q1lcziLMqu
 +xtfpz6X1Naib5e62R2Zh8n11skEYxaQOdBqzIkgw6nSD3itFGkx5l2KsNB4lHwGc/x53qcCwgQ
 yobQs7ZXeVqmXt4eo+NR6qIRRt+aRGo=
X-Authority-Analysis: v=2.4 cv=D+N37PRj c=1 sm=1 tr=0 ts=6a41f4e5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_K2MQWaM9sUw3x3I4k0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: aa5JAUs6Hxxydi8WOo8VBXrkNoRs2ygo
X-Proofpoint-ORIG-GUID: aa5JAUs6Hxxydi8WOo8VBXrkNoRs2ygo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzNCBTYWx0ZWRfXx51L/4T+vZaJ
 bZUIr1NURW2fKnGAtdc3eECYVDV79F7HVtE9scnw9AAFR9Tj5SkQIhkrPcIIdSxZSvVnh6g88wZ
 nEMndO2DQvcSaGcAQDg41I8mi6y/9zBiU/FJmWU+5Vl/hCjU5RVJUOHgPNZQsG4C0fi0MlxvnEb
 U4mbdJ+7KKko14PctI2IAvnLCftJdSP1M2x+pohVHPhNhxvD9muXLT9ha+JYnXHQkwGrt+RDGLQ
 vY+clHzVyajOSJO878+k3IIzHnPws1NBh76nX0ruAlezV8cWdBq9HaKuvY+U3YsUQ4snNpTw2v7
 fBorewxpfCCMBvxJB0sjDJ9sv6sfVZbL0m5mRsjyIAlwvYl8QvwszdYiCMofLrru84c8WMpRFQ+
 cBVSzbOU0o1puz9tVYh3rGrpWuxxus8m0Gd0jg5H3sSaGb7T5DoBof8EwOl4aCJs7qGijJiuP1T
 dF1rMpxgEXoT3qUwNFA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290034
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

QWRkIGJvb3Qtc2VyaWFsLXRlc3Qgc3VwcG9ydCBmb3IgSGV4YWdvbiBhcmNoaXRlY3R1cmUgdXNp
bmcgdGhlIHZpcnQKbWFjaGluZS4KClJldmlld2VkLWJ5OiBGYWJpYW5vIFJvc2FzIDxmYXJvc2Fz
QHN1c2UuZGU+CkFja2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMgfCA4ICsr
KysrKysrCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgfCAyICsrCiAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9ib290LXNl
cmlhbC10ZXN0LmMgYi90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMKaW5kZXggYmNkMGE5
YzUwZTcuLjM3ZmVlN2E5MWM0IDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10
ZXN0LmMKKysrIGIvdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwtdGVzdC5jCkBAIC0xNDIsNiArMTQy
LDEzIEBAIHN0YXRpYyBjb25zdCB1aW50OF90IGtlcm5lbF9zdG0zMnZsZGlzY292ZXJ5W10gPSB7
CiAgICAgMHgwNCwgMHgzOCwgMHgwMSwgMHg0MCAgICAgICAgICAgICAgICAgIC8qIDB4NDAwMTM4
MDQgPSBVU0FSVDEgVFhEICovCiB9OwogCitzdGF0aWMgY29uc3QgdWludDhfdCBiaW9zX2hleGFn
b25bXSA9IHsKKyAgICAweDAwLCAweDQwLCAweDAwLCAweDAxLCAgICAgICAgICAgICAgICAgLyog
aW1tZXh0KCMweDEwMDAwMDAwKSAqLworICAgIDB4MDAsIDB4YzAsIDB4MDAsIDB4NzgsICAgICAg
ICAgICAgICAgICAvKiByMCA9ICMjMHgxMDAwMDAwMCAqLworICAgIDB4NTQsIDB4YzAsIDB4MDAs
IDB4M2MsICAgICAgICAgICAgICAgICAvKiBtZW1iKHIwKyMwKSA9ICMweDU0IFdyaXRlICdUJyAq
LworICAgIDB4ZjgsIDB4ZmYsIDB4ZmYsIDB4NTkgICAgICAgICAgICAgICAgICAvKiBqdW1wIDB4
MCA7IExvb3AgYmFjayB0byBzdGFydCAqLworfTsKKwogdHlwZWRlZiBzdHJ1Y3QgdGVzdGRlZiB7
CiAgICAgY29uc3QgY2hhciAqYXJjaDsgICAgICAgLyogVGFyZ2V0IGFyY2hpdGVjdHVyZSAqLwog
ICAgIGNvbnN0IGNoYXIgKm1hY2hpbmU7ICAgIC8qIE5hbWUgb2YgdGhlIG1hY2hpbmUgKi8KQEAg
LTE5NCw2ICsyMDEsNyBAQCBzdGF0aWMgY29uc3QgdGVzdGRlZl90IHRlc3RzW10gPSB7CiAgICAg
eyAiYXJtIiwgIm1pY3JvYml0IiwgIiIsICJUIiwgc2l6ZW9mKGtlcm5lbF9ucmY1MSksIGtlcm5l
bF9ucmY1MSB9LAogICAgIHsgImFybSIsICJzdG0zMnZsZGlzY292ZXJ5IiwgIiIsICJUIiwKICAg
ICAgIHNpemVvZihrZXJuZWxfc3RtMzJ2bGRpc2NvdmVyeSksIGtlcm5lbF9zdG0zMnZsZGlzY292
ZXJ5IH0sCisgICAgeyAiaGV4YWdvbiIsICJ2aXJ0IiwgIiIsICJUVCIsIHNpemVvZihiaW9zX2hl
eGFnb24pLCBOVUxMLCBiaW9zX2hleGFnb24gfSwKIAogICAgIHsgTlVMTCB9CiB9OwpkaWZmIC0t
Z2l0IGEvdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZApp
bmRleCBlMTU0YWJiMDVkMi4uODIyZTBiZDI4NjkgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L21l
c29uLmJ1aWxkCisrKyBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkCkBAIC0yOTYsNiArMjk2LDgg
QEAgcXRlc3RzX3Jpc2N2NjQgPSBbJ3Jpc2N2LWNzci10ZXN0J10gKyBcCiAgICBbJ2lvbW11LXJp
c2N2LXRlc3QnXSA6IFtdKSArIFwKICAgKGNvbmZpZ19hbGxfZGV2aWNlcy5oYXNfa2V5KCdDT05G
SUdfSzIzMCcpID8gWydrMjMwLXdkdC10ZXN0J10gOiBbXSkKIAorcXRlc3RzX2hleGFnb24gPSBb
J2Jvb3Qtc2VyaWFsLXRlc3QnXQorCiBxb3NfdGVzdF9zcyA9IHNzLnNvdXJjZV9zZXQoKQogcW9z
X3Rlc3Rfc3MuYWRkKAogICAnYWM5Ny10ZXN0LmMnLAotLSAKMi4zNC4xCgo=

