Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BB0C43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIJ-00049b-78; Mon, 29 Jun 2026 09:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHH-0003cp-OE
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHF-0006Cx-0G
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:43:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASuot2603456
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=; b=i1MxTeCFHetTSIIK
 AdPTIbyd54aB7fjjhBqqPz9nMh3b3FbD/16DmMm45D3o4uP7sa7/mbVZGURQ1T95
 cQ+gNCKQAP1SFxS0KD5G8T8CDiG76niegla9UVNYvg4wh8DV3EaLLaAmEks3d+FO
 hChHthGw2h0HqgGACJhNP8uZEZkfZ25EudgNWip6empO2+RUR17DIL21NCga68z3
 ADVjiOXVlRlAuktKH8DMOEx4p5LHg2r/mwWn19/l4kyXMNbnjJfHxsxCRdAN0AxI
 IzAETtSdTQKrV8RZA4KLSV1WKJdnQcTNA1cplHRi8U0aOnxATDfizLeHv3xhDNRL
 L4K7cg==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nq892mb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:43:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c89956023dbso1993865a12.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740635; x=1783345435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=RC+ZMEe+rl46DAiN5+kyfuED25MUvwmQuSS3zs9Tln6SexTGjWR+cEm8BkDQkaTc8v
 knvKXTHzp3MBZAypgUtS33C05tBRDt0Vh23fUlRd5JMgJc2wIR+qYE+OKCui8xS4svIk
 umFFFjxq9bc/7Zn4tXw4FE2wB+RnXhk2WV8HuIYb6o/InoWuw20uhZbY0Sjj+MZwlU/A
 Ht3bvx4xQaniaBUhgrE5hMyir/JmC0qrjVbH7J4PQ2zPCv69rchPeM2vEDxhlcVwbUTq
 jI6zJUzs4soDduDS6UY/Lcq4dTci3+qNZu2NuC/qhf194Jd9LzROuk/H/gsgd65p4PxC
 0wMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740635; x=1783345435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4hsqE0JDPfvXJ30nhCZ/CCXuACFuBC+IpE9moxChOvw=;
 b=rVfiQaW5A4nGoTUaKTfdlIVrvJBGm5pNNdcd/boJrdzBxA3jdKl8Kc+3PlpFTxTtVs
 z1NW5dUveNZoSrDYVH1ETz/R8bD3bTs6RM+niOOIibbzzoWueXnsIV+YutlL0rEBZ64B
 3Iv+ET9kGAYFDouGaosg2UUY6iIiop52owmSmXNHZeSyaesB7AW21MYNVfHs0zAWv5/c
 5nPIfe/pLAeLFUomAUhRDx+ngZssnsFENTXLAr40bCh2gL1fvPVEWJ2eKkN8FkQtnUxo
 ByhpnVzZ/E9XQsJecU3WoO/PAET9GIbEq0xUn3N19e187JZTiUs0UR4btzBdpidqvIho
 SpbQ==
X-Gm-Message-State: AOJu0Yy81PNNT60rhpx4JG7C5TnTVXtYSDkPPzvTg5V0xy1qcF6TAhyj
 wDd//gn6BKjTQKFXtlhIwVCpYiE66vuE/QBSJdRDa9NlIEG6uDw0KbG1vUeMzjH21hWBuH8N/dt
 YyRrkMPviFJ4pYDIXB6wkiZKRuMVDJGEjCEHMSRIqiGNaCfrvx7F4HoDOgYHJu4yG4w==
X-Gm-Gg: AfdE7cmzhoAq/Ep4mQIsEV9yyG2dZwO0T9hXRrMZ2OmhRLVX1cxUon9xwSD7k8p93ha
 nNYeEytx8yW0uPmEV0X+zbrZ6sYoygdv40qBdkDArztGKYa32OD6iaKUeaZ5fob2uRwW9gWfvlJ
 VADNwnc0Q1FhDI+XpxE+qsKExC0TSmzrfN4EzjYAM3nJpRCrbqft2XDsGlsVBrO+z4/hHL3QS5l
 WgG5SFnwhO1YdVvZ3pUzdJ97iuZ/KUGrRCVDXif82UuhmGOViWxur4L4836D/8OLAUHzKHi9zKp
 Rw5pw14zqwgS/xPNzzoOgahRBjlk8msrsRTk9cAQKNIo5CZBtZyA22+Ru0LlTOsSJqx8VxZkLBT
 bujqH/1Fvk3453kUWUjH5fTXC6kgSXYPojq1uOdY+/2PShgAiZxxRrsd0Aqs=
X-Received: by 2002:a17:903:32c3:b0:2c9:b2cd:e282 with SMTP id
 d9443c01a7336-2c9b2cde545mr67360885ad.14.1782740634953; 
 Mon, 29 Jun 2026 06:43:54 -0700 (PDT)
X-Received: by 2002:a17:903:32c3:b0:2c9:b2cd:e282 with SMTP id
 d9443c01a7336-2c9b2cde545mr67360705ad.14.1782740634546; 
 Mon, 29 Jun 2026 06:43:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.43.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:43:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>
Subject: [PULL v5 47/77] target/hexagon: Implement hex_tlb_entry_get_perm()
Date: Mon, 29 Jun 2026 06:12:02 -0700
Message-Id: <20260629131232.2487780-48-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: pjaSaNAodHKvZ9SI0W-IjhUf-RMt2R1M
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX47nhRg1LADru
 mkQyvntPLX5kadw6VnMOGQvbtqcC/37SlAYQGPjSYXAVrS9002NYgEUTGAcU3AxpGPUomd0NGyP
 x3ao2KhB2MsfV2aBy8RGq1R6Ys1tRnY=
X-Proofpoint-ORIG-GUID: pjaSaNAodHKvZ9SI0W-IjhUf-RMt2R1M
X-Authority-Analysis: v=2.4 cv=PqSjqQM3 c=1 sm=1 tr=0 ts=6a42769b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=RKVJoAg1yBLoogzcrgwA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfXzwgsFK2DXnC+
 TXMpjwNlJYBVpUVdIcrCNoPKugflz0Q12ZqzMJOmHCoBUABFHQdmHhodp2L/SzFTfDV4btQU1uX
 1dExzrcb4S11uNWT4tt8Wj8nrLxKYvoR5/xGJvZar+e9Q732U4vUKTfpiXcg1gD0uBuEz0PgiJ6
 8FPUwrfnnzXVztBZeAPnS1TQRCXWIR7hBAFVqGnXAXYVhjdcLai4Z/NcgyhW87TwtPdY6jNGJb4
 7K4Ga9CoYG0ybraV6cw+QV8RwmFTfGyK5JHoOBtu2uzdkZC7Hh+y9nTrcAfMZP5SDZPW84KBB7q
 pTojkRzSYdKq0jcyICNJGGrpahE5Z/7bCrhC2JB0k+W0hfNO0KtUhGJGq6q2Vw9myeDt6+/rj66
 2YeXkMwwcQuJB8ILTGgZpFYzIgYy4VUJpFu8A/ip3pskofzJPB8GkBw2Mcb3asK+PVCTx4byDKA
 T+5lnJSeEE6F47kNPjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 malwarescore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290114
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGxpbnV4LXVzZXIvaGV4YWdv
bi9jcHVfbG9vcC5jIHwgNyArKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvbGludXgtdXNlci9oZXhhZ29uL2NwdV9sb29wLmMgYi9saW51eC11c2Vy
L2hleGFnb24vY3B1X2xvb3AuYwppbmRleCA5ZjU0YzdiM2Y5Ni4uMDk1OGM1MWZiYjMgMTAwNjQ0
Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9jcHVfbG9vcC5jCisrKyBiL2xpbnV4LXVzZXIvaGV4
YWdvbi9jcHVfbG9vcC5jCkBAIC02Myw2ICs2MywxMyBAQCB2b2lkIGNwdV9sb29wKENQVUhleGFn
b25TdGF0ZSAqZW52KQogICAgICAgICAgICAgYnJlYWs7CiAgICAgICAgIGNhc2UgSEVYX0VWRU5U
X1BSRUNJU0U6CiAgICAgICAgICAgICBzd2l0Y2ggKGVudi0+Y2F1c2VfY29kZSkgeworICAgICAg
ICAgICAgY2FzZSBIRVhfQ0FVU0VfRkVUQ0hfTk9fVVBBR0U6CisgICAgICAgICAgICBjYXNlIEhF
WF9DQVVTRV9QUklWX05PX1VSRUFEOgorICAgICAgICAgICAgY2FzZSBIRVhfQ0FVU0VfUFJJVl9O
T19VV1JJVEU6CisgICAgICAgICAgICBmb3JjZV9zaWdfZmF1bHQoVEFSR0VUX1NJR1NFR1YsIFRB
UkdFVF9TRUdWX01BUEVSUiwKKyAgICAgICAgICAgICAgICAgICAgZW52LT5ncHJbSEVYX1JFR19Q
Q10pOworCisgICAgICAgICAgICBicmVhazsKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BS
SVZfVVNFUl9OT19HSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX1BSSVZfVVNFUl9O
T19TSU5TTjoKICAgICAgICAgICAgIGNhc2UgSEVYX0NBVVNFX0lOVkFMSURfUEFDS0VUOgotLSAK
Mi4zNC4xCgo=

