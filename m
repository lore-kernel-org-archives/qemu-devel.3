Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73014C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we399-0001Xz-Bd; Sun, 28 Jun 2026 23:58:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we393-0001Vf-0E
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we38x-0006Am-Iw
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:58:50 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2dKGC1555438
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=011SrS5GzZCft5XXyTaQlyV1WtjpEAOEvGsDEjZd6oU=; b=dH
 hyuMI1acKV+MhvOXJWmoC/w+UMBrpRpj1+ALSAC/kWVCwqbJ8uKJqiwTaElsLsIN
 QSqqwv1Yl75+xdQnlrW/JV3Bc+PwdBIoPtSTus48Xgpv/mq3ePpgERtc1b5Yvttv
 iZ9meIo/7nckWB8ULm/Ie/AswHMuDnZNrnSRjy8b7yptbZ+A67ZsO8wVhijIQAvB
 pYmowtYmEMFieSmSL5zuum+OfpyCqHG88TAvN8adXKDNQOQGffTkQK9UWK5EOU80
 jg9/5Ozoxae6gWOjAu4hRWtnCquwey68VqFALvMGmDTlOQByrE3LIsEIvtilx7JR
 W9ADZzm7QBVv7qVVZIJw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26u74e6u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:58:44 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1383723dfddso4473101c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705523; x=1783310323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=011SrS5GzZCft5XXyTaQlyV1WtjpEAOEvGsDEjZd6oU=;
 b=dd9xroe3Oe26XH4hwhPBHvvkErlFI1dbCcpoma+8e/Twv1OG2d589xZPYghEleeVQv
 DLUu/Hv6IHnENApc5cc3LloCjqt8oQOrqzfHTOlJjtsvUP4T8kKwOR4+ye8MxJM/4snB
 pOEjLNHk1m2cHIksJG0KXLMReGES8DjtSAygbqd1YmDrSBcak37lidRXd/qF5pnYcmet
 Pw2LBL6acEa8q4/BAv5nAHUD4vzWPIwlhT0F79tmCl2vkO2wVnymRNyrWotS/+7zwIhO
 zuw2zB327qCV4nqWXhzM9oD+ARRSn+SwpU2r4mH/Q4yZTt1f0lkm8cztF9U36uaxrOy9
 eTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705523; x=1783310323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=011SrS5GzZCft5XXyTaQlyV1WtjpEAOEvGsDEjZd6oU=;
 b=sOFAuQd9Pmp6bmQwS7bloG9o0G7u1F14LRlYMj+GUNjZR9FJSug7frTdiw2+ywGzEp
 x1HrvRhxbHI1463WbUe6BTjLgY6c9VvkdBZ16QTgknVF+9/3RT44TnOiwXJzRZgomZ3H
 EOotSWgGUUYt2TK4KzQSbjbQt+QPwQ/X0XspwqR7NtCxXCnyC2yhDR6yiJ9uUOPkb/dH
 NTFijK8gIzsI2tf1DyPotKMGpo3ldcc8ZWO0SfSw23l9am8OHKRg3PXvDzjUm72epUQu
 tputEEMYNxvzw5b7W97fFEh1Y4QtnrAlh/a/LyN0MMu0kOJe+j0nDvQmXAkqHstNzLyN
 5ndg==
X-Gm-Message-State: AOJu0Yy7xGYD+Q7tYCEdCKJoq5WoWRmBa+0gaGCK3hql68Cq4umtipZs
 gd/jOn6k8abpMVP6KWZ5lrLxOic4MVcssoyR5zchFEfJ9OGUdqiD0umTUtVhceCMBIgIYLETEY4
 61H4crELqLOTPJhQpWG4bLttgEi6KzS+UG7inK+Hxx2dKN3zys1W7wrKHLl4wQ6KDKA==
X-Gm-Gg: AfdE7clS8+pnP3Hqb193Bee2ugxqCzKSBrHxwJVFcBfx2r2WnLF/UtCJIwZMfhFzyNq
 WG06aL2SkgJYttB/yWpbr79N85UqhyewqrTBS8VrWVDeIEizTE3oErl3QTpY/hWwPt+dj10e/C5
 2ndiJjWACVfDgCq429Qwt1Wds+tyNt78XzBOYvTRmX+AVTpS8HkiU98byNW0SgUs9lAJA8R/pDg
 ocDeT8dK1JyCYTGUhIwWhpqrK2eoiFzGnCUNx2gNcGl0xDUuGA2PimoLzWTRbLWj7TFrf5U78+M
 fNZTTwRleHGfis7HdhstsH6N/soVI46CooanAVN9Z/EwYpVsFPFplhQEeTai7e9Z65dF2xm4jv8
 Y2fbHVBBjQ2qEmZDDBqDMEVf8GVfJh3dprwF61sSEwttPn0xjWUcZG0NtrAM=
X-Received: by 2002:a05:7022:2585:b0:137:9399:fc59 with SMTP id
 a92af1059eb24-139dbac8341mr11650787c88.21.1782705523140; 
 Sun, 28 Jun 2026 20:58:43 -0700 (PDT)
X-Received: by 2002:a05:7022:2585:b0:137:9399:fc59 with SMTP id
 a92af1059eb24-139dbac8341mr11650779c88.21.1782705522663; 
 Sun, 28 Jun 2026 20:58:42 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:58:42 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL v4 01/77] tests/docker: add flex and bison to emsdk-wasm64-cross
Date: Sun, 28 Jun 2026 20:57:14 -0700
Message-Id: <20260629035830.1520296-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfXxcIN38Hh0dCF
 ASBCkoyiB72QgbnXpxGIXnuAQxSiQMScEmeqfnwbaL/u03mpLDU7psk42iY3XwAJRfcPVvEpomA
 p+6m8343o/AjsuDBm3smDOEBu5TI06I=
X-Authority-Analysis: v=2.4 cv=ftnsol4f c=1 sm=1 tr=0 ts=6a41ed74 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8
 a=dTW7Cx3YwPv8u8hf8ikA:9 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-GUID: yXycWgoca2XdVo-DDCwe-2ER3sLt8F9x
X-Proofpoint-ORIG-GUID: yXycWgoca2XdVo-DDCwe-2ER3sLt8F9x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX87Hg1jXBF26U
 4GBKDqUwRBwcsbxqdPnDqDhtmUanZBqrxG3X55SCN1okRqMvirevwVclGV2MwStjHmS6dxnqOMt
 gXiOwFmq5kX1UqdI0ketKoLOGhEPsb5AzZgxSUF+n7ETNE/4U+UjB1NTTcOk4R1AqXFcTxsaOfX
 XZ0pc6TwqVSIJYHuev/BdOYocbtFeLgxiv1gdvkqXOgNptvFMe/z/4XwrqkQQ7jREMzG2Ks2cDU
 xVXwpAtY6diLCulE0NF7PvqhHYLGXuWdcjofGxd6kaCbSmtMsyH8nvXh19zSAYKS+zW57u3Io2c
 abdex0lKlrm4OWz6Q7YykKkvaBbmbOTITbRnfOogeswcj1TaAEnZZXleNNSfkbe6xf5uJdmbEeK
 1zK/WrXfnmn+kd+3Q5y2kbOrI04/vYDRi5zEzAd+tc8o3P4WvutNuXVD/AGgHxFrXhWUl2Kz/kJ
 MNi35bByIqA0m159X4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
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

VGhlIGhleGFnb24gaWRlZi1wYXJzZXIgcmVxdWlyZXMgZmxleCBhbmQgYmlzb24gYXMgaG9zdCBi
dWlsZAp0b29scy4gIEFkZCB0aGVtIHRvIHRoZSBlbXNkay13YXNtNjQtY3Jvc3MgY29udGFpbmVy
IGltYWdlIHNvIHRoYXQKd2FzbTY0IGJ1aWxkcyBpbmNsdWRpbmcgaGV4YWdvbi1zb2Z0bW11IGNh
biBmaW5kIHRoZW0uCgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL0NB
SlNQMFFWazZ3c09uUEFzcEM0WWZYUnA5MHNhS2liUWZENE1rLTQ0LVJRbzBrPXozd0BtYWlsLmdt
YWlsLmNvbS8KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFA
cmVkaGF0LmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
b3NzLnF1YWxjb21tLmNvbT4KUmV2aWV3ZWQtYnk6IEtvaGVpIFRva3VuYWdhIDxrdG9rdW5hZ2Eu
bWFpbEBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZW1zZGstd2FzbTY0
LWNyb3NzLmRvY2tlciB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykKCmRp
ZmYgLS1naXQgYS90ZXN0cy9kb2NrZXIvZG9ja2VyZmlsZXMvZW1zZGstd2FzbTY0LWNyb3NzLmRv
Y2tlciBiL3Rlc3RzL2RvY2tlci9kb2NrZXJmaWxlcy9lbXNkay13YXNtNjQtY3Jvc3MuZG9ja2Vy
CmluZGV4IGNiZTIwYzcxOTNlLi5jMDRhNzQxYjBlNSAxMDA2NDQKLS0tIGEvdGVzdHMvZG9ja2Vy
L2RvY2tlcmZpbGVzL2Vtc2RrLXdhc202NC1jcm9zcy5kb2NrZXIKKysrIGIvdGVzdHMvZG9ja2Vy
L2RvY2tlcmZpbGVzL2Vtc2RrLXdhc202NC1jcm9zcy5kb2NrZXIKQEAgLTE5LDcgKzE5LDkgQEAg
RU5WIENYWEZMQUdTPSIkQ0ZMQUdTIgogRU5WIExERkxBR1M9Ii1zV0FTTV9CSUdJTlQgLXNBU1lO
Q0lGWT0xIC1MJFRBUkdFVC9saWIiCiBSVU4gYXB0LWdldCB1cGRhdGUgJiYgYXB0LWdldCBpbnN0
YWxsIC15IFwKICAgICBhdXRvY29uZiBcCisgICAgYmlzb24gXAogICAgIGJ1aWxkLWVzc2VudGlh
bCBcCisgICAgZmxleCBcCiAgICAgbGliZ2xpYjIuMC1kZXYgXAogICAgIGxpYnRvb2wgXAogICAg
IHBrZ2NvbmYgXAotLSAKMi4zNC4xCgo=

