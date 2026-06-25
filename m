Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7CECDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclOD-0003mA-4n; Thu, 25 Jun 2026 10:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclO6-0002zH-Us
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclO5-0000Gw-9x
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:49:06 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9k0AJ1398023
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=gn83dxXALMHX9hShj5DO/MP/66YGPFEzq+6xQ++j3U4=; b=cW
 ti+yCTkQaaHpPfJoMVl0+TpIYw8zjToZGxnLKYUyt0UeusbQblNGOvDl/4wqR8QW
 +znAvvLU3OLbdn4iozfVYGzb3JVs+jD87m33av7xI0zjX0VrJLSKWHPW8AEcBmfm
 dQaWl7JEu4MZz3hX/TZ0TvwxXHUWCx57m0/DmrzYZzrwmJgaJmRzmGHXh0rlxKTZ
 OXZliZSV8hG1wEC6kfpeMu2swBITfZnl1y3h+ZnKt6/wCAKqSohtEjIXteLqRDvm
 EsH5ikKR3MZqno3Cf6nZegbiG77RsPcaGiOGhMEMKG8r1/pXEku8CEJXNm2n/jrb
 X/cn7sW/+Pjlg673JsLA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0uudjms9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:49:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30c17f62afdso955688eec.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398943; x=1783003743; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gn83dxXALMHX9hShj5DO/MP/66YGPFEzq+6xQ++j3U4=;
 b=ZIlRY+XZSG6LddweMQyoMtf4jWoUfF/zQ5GSUVFHOreMGLQMoH9Rc3tYVd64QFW9Pr
 yiQbmhPN/db+vw1qbPMuWWMT3xkoWhyHjTwpTyttXPlCWO51yzMgBpBwqjQpbVKZ0hd9
 xxQVSCABauoEy5CyyH0agz5JFvMlcyL+GoPH3IekMZgDm3uJ6WvdVpFXiFf/fNS8GEFi
 jj6cZkMUwJ39Sacr061vZuN/3h+rXPSIGDx35HA2EGCmgRMSXMtFR6KkaDmXNvnkHgid
 UyySU26A600V4Z4h5OT1GtraSCA+PhjFtTigHNhGwxkA3ZWbuNHjNR5w6HLpDuB7j8ch
 aVoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398943; x=1783003743;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gn83dxXALMHX9hShj5DO/MP/66YGPFEzq+6xQ++j3U4=;
 b=lKcUHHSD/xp0AjAe6gEJptKOkCLrdijwUlrfSAmAK+MTspuVAhdNe9VQ70RXEgjk50
 ild89d4i/Ebw3uFKrKSEzzsyV3qF6F9JrPG0lw5luGCVim8Zu46S4mJ96ycew/cM4WMG
 BkgHoLH1nsbFxWaLoiLjnbl/hRA4gIjigNxmPebGUMddX5kEsRJwxbyyT1/vndRNChas
 esF2JRpwELDZ8JuxhQHw1mukbPez0La+DBenvgjRiWA4fJeqvHdD7ODDtVgRrHmjFVA4
 lR1Lc+GNsl8bK+uf5v0XMlteI9vRtLF7YEiJLwFpqa9+7S64bzhkXoEkewqBO4hojS/V
 W4nA==
X-Gm-Message-State: AOJu0YyW9B2eLAFq9ORIKDh5mVWh7qNveq3b136BpVa7BTmlg35pNord
 7wWqLSzDkvOf7KflDjmDoAil2wswcqat8KOdSSH7SQvdLJfV/0BQiMDdfKAni7HioK3GckfoVpv
 iMKvnbezsp4r2+z4KJgShfwkVR1m++JUrXKNACntjEbpMDXVVcUfKx5xqmE5jltvhlg==
X-Gm-Gg: AfdE7cm0IPuaFdNUuwiEHv8ccmOZrFyR/AMkE3xs9s/nWxnUb/ifbQG54UVaA1JdNnK
 y/YlF3O59TaNOX0sy0yIC/RBwqsfNchY6k/7wpARPjWtBfT6+kxAfh+XkqVPXCVdChCelC9Ayd7
 xGeacHugDGQ5csSVvRTUwp6F3T7EdzsJMK8kuEJu5E2ToJoEv+VveHCWpCBI3RE6YBpO6bdITBv
 2UOmIaEp3g3hUiziNf4z5S9iLVUbqbxzelh0Du/EgKzO6iv6L80Eql2z4xOmgMTxBZzYT2HJzKO
 ANTnkHdNxM/zyGOsJ58y0afUXd4e+cSsukmjwL/niwvq2GGU++kkA3YVTydxuU0AVeCvjOCO9uK
 kdujK1nM58QtLtsDHkROxW6byLDNvIyJtn0/N8TuoUmTvx61TbTnW9XTSSDw=
X-Received: by 2002:a05:7300:80cc:b0:30c:1fb5:94b1 with SMTP id
 5a478bee46e88-30c5553657amr12583310eec.6.1782398943126; 
 Thu, 25 Jun 2026 07:49:03 -0700 (PDT)
X-Received: by 2002:a05:7300:80cc:b0:30c:1fb5:94b1 with SMTP id
 5a478bee46e88-30c5553657amr12583260eec.6.1782398942358; 
 Thu, 25 Jun 2026 07:49:02 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:49:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v3 76/76] tests/qtest: Add hexagon boot-serial-test
Date: Thu, 25 Jun 2026 07:16:33 -0700
Message-Id: <20260625141633.449487-77-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX5Zvelo9rB4kS
 uPNLhdphuU1kSjQRx1oLyFugHtGs0niolAGWy5gBDDCT+M0evF/pivsD0kM0DKptM6Ic+4Enmn9
 jdJRJ4eZwyGqP+gnzuV/WdjTfM56SrA=
X-Proofpoint-ORIG-GUID: 22fxd8sGpFdFr_rzbNOx1-udpL6jNUCB
X-Proofpoint-GUID: 22fxd8sGpFdFr_rzbNOx1-udpL6jNUCB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfXzdvEuOEdJ+ye
 bwfYxZKep1KRjgc/VHV9VBWmS3//CmytwjI0nTPpCBSu14JmUBpnEoN1+sGLvGy+9Lea+mJQwj+
 Ow/fuJ+lmAAKaJBoWL2Xv3d5VHg0XiGBsrqbkVqi/dJxlr/x7/0aAGkyi+HQWZOCRtw2O3LBNiG
 GZ6yyDeDfuEktwsw3rlcbPfWdBEA15XY0P5xrRZYwIdUnCP6Rm0YSvqHHeEEOKjGjrTlmthIKRa
 xDfIFvuWQKZvjW2qmBe839tPLJUugF+Bu+/qYaNA4DKUunfufZ9AMqlXNJ1Zv2ocdVcQNMl4UbV
 qcprTSziF6XL1JYxzGo2VWKD8rKEc6kKXfFy+iVEURshnQunvPim6Lc5gtPFzyJEufpj1mzqmQn
 V1dgmPr9WDNy5zQPS00KXiRs3HTUzEUBZ2J7TvgmUJWViUfcXL/dLty5eJxVT1hdr9Ld3T2G018
 XPRZU1C5cWKB/YkTuaw==
X-Authority-Analysis: v=2.4 cv=HdckiCE8 c=1 sm=1 tr=0 ts=6a3d3fdf cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_K2MQWaM9sUw3x3I4k0A:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250127
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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
bmRleCA0ODk3MzI1ZDg0YS4uYjJkMzY0OTlkMjcgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L21l
c29uLmJ1aWxkCisrKyBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkCkBAIC0yOTUsNiArMjk1LDgg
QEAgcXRlc3RzX3Jpc2N2NjQgPSBbJ3Jpc2N2LWNzci10ZXN0J10gKyBcCiAgICBbJ2lvbW11LXJp
c2N2LXRlc3QnXSA6IFtdKSArIFwKICAgKGNvbmZpZ19hbGxfZGV2aWNlcy5oYXNfa2V5KCdDT05G
SUdfSzIzMCcpID8gWydrMjMwLXdkdC10ZXN0J10gOiBbXSkKIAorcXRlc3RzX2hleGFnb24gPSBb
J2Jvb3Qtc2VyaWFsLXRlc3QnXQorCiBxb3NfdGVzdF9zcyA9IHNzLnNvdXJjZV9zZXQoKQogcW9z
X3Rlc3Rfc3MuYWRkKAogICAnYWM5Ny10ZXN0LmMnLAotLSAKMi4zNC4xCgo=

