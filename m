Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7992DC624DB
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 20:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2weG-0001Td-Pf; Sat, 05 Sep 2026 16:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weF-0001TB-BK
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:05:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2weD-00060g-HT
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 16:05:59 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 685Hbepj1775030
 for <qemu-devel@nongnu.org>; Sat, 5 Sep 2026 20:05:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hcIs9hWNYLJijBDDF/u18K6Zd18OUHtUFgLtDpWfTdQ=; b=aqoMq0FIiw2lgZEr
 dHe4yNsIKukugae+tWmXREPXGh8Zs4aHXpgOJJXCbjqeU0gSs7+jnRYROSt14Ksc
 zY5R0ZCWC03iXUzCEOxhJyozFV9CtDzwjx6YmaDda7UMiyk5VaGKm5OgR+VL6wAF
 ymyhkNeOPhDAQBdBTEy3wesWSOfeL1OfccKDiUDvchX1eHcRi8ZcUyTj/99ErXvB
 LAD+o7Oxfq6M/muek1/Ocma+otfv2UvDh93sHR4dj/9f6VctOw321VLEITy/IcXR
 DcZtrvCOp87++iXhyq4/5QmtsLsZ6QElEF6gUQj1J7FnchiuZ89YXk/M/FBfs0SF
 zYO2TA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggc8ja1a7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 20:05:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-395543dc382so2931512a91.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 13:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788638755; x=1789243555; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hcIs9hWNYLJijBDDF/u18K6Zd18OUHtUFgLtDpWfTdQ=;
 b=KBiWk0kRU+1W7ZMl6sagqiR00hHqqX9iuY4QK5DYlVhGJDXR15uWCmCiQRP2nwZzk8
 1gjc2FxPWpziHxRjJtFo0blV/Zrx6e5uc01C914Hmq2fzG+ASREtiXAXXjvQqw0aNDfo
 ICkazP1XIlqVrtuLrno37NuejVgTZkwTo7vADvFAt3vnY3alOY9Gxruf6z4fnW2O/Yvi
 HMVq4N6a9dAb+HOVv0Fjv6UAGnNM5gAipAz5R0Q2mtgMWv1yoaAOV34fQw9/QlM5P5KE
 3GgAGwl4cYkY2O8FLWs07sniBTq63SgyFEOg3cyOn7NMReMK7lJ83ZjhiqAj+l4TxkZ1
 y4VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788638755; x=1789243555;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hcIs9hWNYLJijBDDF/u18K6Zd18OUHtUFgLtDpWfTdQ=;
 b=Xe4iN5uCASkddhVzEH7wTNmKDNAu/S5w4IPBl7kdVjSrN6sKXvjrE3Cko+s825Y7sl
 SbpZ4Em6Azisj16hnvQf/xPS4j7P3PoNmof8r+KrNCxzRzI/C2cRZeXIpLwP9ABsbyYt
 RGKALAsSUc/NSmyU/UJIvMI1XvlKIYxVarIgr5Nu3OO6dqdiJU+qwSwM/aEiG02GRe2f
 4OpqJdPVkClLQk4BTFtNCKUCZFfSb+kGPIfIDOVmRiBxo4avc9AZlKtNoQvGcGQ0BwEl
 tKWUQg08tch4i50TyZY0Nsx7m/nHltGz68jhinyL4KIS1nxiJgEzgPEJ941V/E5hS1Cq
 rbUg==
X-Gm-Message-State: AFuF++m9GOADUiuNTz1swoyh4SH2Y8m3a84eZjYn+uzDHJh3e76zUi6W
 3iP6xHaMUt5nG/lyvJ3UnrlLxdVQtKugQg5ALtor9tMdkmdtw6GPF+zti9fE7EUZi3T4r90Q5Pp
 6NkiBYf0d6RvKUhKR9OqxDkxS8KHu0diCfCNbFZEKB6KBT7tRVCuaw/uVDGupvULwDw==
X-Gm-Gg: AYBFou3KEto76Kr9QaJuhJkkqHlnyBhFFQ+v0urI9ZMsxiCAc/Rx6C72Io6cxR71LkM
 DPScMFSghyd0XveRVheq6m9aGpKx+W7e7GprjKsT6chuE6cPniSAJfOXCWgoiVO+6sW1wHDKh0w
 1KRbCTpCYrzU7QjnS8RGRgyW0Yb+kRaRSG2fgJU9LP0C6lZSglv2Ra3rHEcTM8QBC9fe0BJDEY0
 EHGSo2bAlapmcOLytbq2vzubFm+ZJVB2BLTmTGBZK2hMGtn4YKkyG5gpRAzFuPl4lymz6awboZ/
 RAJnG4DsKqzQRKNjjuHuMGDpL/sXxZyJd/SjBL1CDcRUBupgmIANsMNP/Ryztw5Oq/9v35MG9MJ
 S7dlQgTQxPyVPWL8GA3y4DjlEsWP+fVG015UHERVyOXC6HBh2
X-Received: by 2002:a17:90b:35cb:b0:398:a486:81ec with SMTP id
 98e67ed59e1d1-39b261ae617mr25007989a91.11.1788638755410; 
 Sat, 05 Sep 2026 13:05:55 -0700 (PDT)
X-Received: by 2002:a17:90b:35cb:b0:398:a486:81ec with SMTP id
 98e67ed59e1d1-39b261ae617mr25007910a91.11.1788638754784; 
 Sat, 05 Sep 2026 13:05:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bbebf2fsm17346075eec.25.2026.09.05.13.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 13:05:54 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 1/9] hw/hexagon: register the V68N_1024 machine
Date: Sat,  5 Sep 2026 13:05:42 -0700
Message-Id: <20260905200550.2009799-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
References: <20260905200550.2009799-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: -81Psr2xrTKpj4qum_3K4b3YSzTymu2g
X-Proofpoint-ORIG-GUID: -81Psr2xrTKpj4qum_3K4b3YSzTymu2g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfXzyg7hJ+LDPsC
 Y+FAVwLndXX+IDXJgDvjQeijo4mMLo11N400wcY1NG8Hqb/Bz0jfVnvYh0U4bmZnzKtIPchNvIE
 9CXCPUzpS1lxpQzywdD32mFzx2E3W/KKui4c2LQFwTdjBQmR9SviPCAuN2kfQgvemzLUGJP2TXd
 K+dBC2GsLekki2jJPKHum1c/edIQi2Ib0kNN6vYa6XgTu/ZtqPyYx+9fGLGGJlmQ3YVlKXdwdtA
 MKW95+xyaJoh05rK1IZGHh0mmsCc5sruthNi8lui/dwd4YJced0Q9L6XnakQJJ4+dNtCSvmOpZw
 R4Pl6khAsiCQ/Pv8R9EpHijXaML90GMozgkGjudFNNLqxaGMPzAbiiurhtFB9YQkwYZl0Tt3bvn
 Z4lcokzfFgrtWZHD17n79VfkNteLQ6wg+m32fng58xnK7zkOR4MsOy4lTGKHEeWWU+ElHuYz9j2
 GaLSqHsBn6Civ1cyxJg==
X-Authority-Analysis: v=2.4 cv=DYgnbPtW c=1 sm=1 tr=0 ts=6a9c7624 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=LGeOnwBDO1WtItRKohQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA1MDIyMyBTYWx0ZWRfX8uwnVV9lx79J
 980daajf8b9qYBB+VzKBDNpq0w7X1f08BNxeJszRquchLRB9BXIcpLJy5/7fkguEJbzEI3e/c0F
 4AbM6gdzJ+feE8sy9DshjaxB6Ic/lpg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-05_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609050223
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

VGhpcyBEU1AgZGVmaW5pdGlvbiBmaWxlIHdhcyBwcmVzZW50IGJ1dCBub3QgcmVmZXJlbmNlZC4g
IEFsc286IGFkZCBhCidzaW0nIGFsaWFzIGZvciB0aGlzIG1hY2hpbmUgdG8gaW5kaWNhdGUgYSBy
ZWNlbnQgbWFjaGluZSB3aXRoCm1lbW9yeS1tYXAgcmVzZW1ibGluZyB0aGF0IHVzZWQgYnkgJ2hl
eGFnb24tc2ltJy4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2
aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNh
aW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleGFnb25fZHNwLmMgfCAyMyAr
KysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMgYi9ody9oZXhhZ29uL2hleGFn
b25fZHNwLmMKaW5kZXggNWIyYjZlMzEyYjYuLmZmMTEwMjM0YjA5IDEwMDY0NAotLS0gYS9ody9o
ZXhhZ29uL2hleGFnb25fZHNwLmMKKysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCkBAIC0y
OSw2ICsyOSw3IEBACiAjaW5jbHVkZSAic2VtaWhvc3Rpbmcvc2VtaWhvc3QuaCIKIAogI2luY2x1
ZGUgIm1hY2hpbmVfY2ZnX3Y2NmdfMTAyNC5oLmluYyIKKyNpbmNsdWRlICJtYWNoaW5lX2NmZ192
NjhuXzEwMjQuaC5pbmMiCiAKICNkZWZpbmUgVFlQRV9IRVhBR09OX0RTUF9NQUNISU5FICJoZXhh
Z29uLWRzcC1tYWNoaW5lIgogT0JKRUNUX0RFQ0xBUkVfU0lNUExFX1RZUEUoSGV4YWdvbkRzcE1h
Y2hpbmVTdGF0ZSwgSEVYQUdPTl9EU1BfTUFDSElORSkKQEAgLTE4MSw2ICsxODIsMjMgQEAgc3Rh
dGljIHZvaWQgdjY2Z18xMDI0X2luaXQoT2JqZWN0Q2xhc3MgKm9jLCBjb25zdCB2b2lkICpkYXRh
KQogICAgIG1jLT5kZWZhdWx0X2NwdXMgPSA0OwogfQogCitzdGF0aWMgdm9pZCB2NjhuXzEwMjRf
Y29uZmlnX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lKQoreworICAgIGhleGFnb25fY29tbW9u
X2luaXQobWFjaGluZSwgdjY4X3JldiwgJnY2OG5fMTAyNCk7Cit9CisKK3N0YXRpYyB2b2lkIHY2
OG5fMTAyNF9pbml0KE9iamVjdENsYXNzICpvYywgY29uc3Qgdm9pZCAqZGF0YSkKK3sKKyAgICBN
YWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9DTEFTUyhvYyk7CisKKyAgICBtYy0+ZGVzYyA9ICJI
ZXhhZ29uIFY2OE5fMTAyNCI7CisgICAgbWMtPmFsaWFzID0gInNpbSI7CisgICAgbWMtPmluaXQg
PSB2NjhuXzEwMjRfY29uZmlnX2luaXQ7CisgICAgaW5pdF9tYyhtYyk7CisgICAgbWMtPmRlZmF1
bHRfY3B1X3R5cGUgPSBUWVBFX0hFWEFHT05fQ1BVX1Y2ODsKKyAgICBtYy0+ZGVmYXVsdF9jcHVz
ID0gNjsKK30KKwogc3RhdGljIGNvbnN0IFR5cGVJbmZvIGhleGFnb25fbWFjaGluZV90eXBlc1td
ID0gewogICAgIHsKICAgICAgICAgLm5hbWUgPSBUWVBFX0hFWEFHT05fQ09NTU9OX01BQ0hJTkUs
CkBAIC0xOTksNiArMjE3LDExIEBAIHN0YXRpYyBjb25zdCBUeXBlSW5mbyBoZXhhZ29uX21hY2hp
bmVfdHlwZXNbXSA9IHsKICAgICAgICAgLnBhcmVudCA9IFRZUEVfSEVYQUdPTl9EU1BfTUFDSElO
RSwKICAgICAgICAgLmNsYXNzX2luaXQgPSB2NjZnXzEwMjRfaW5pdCwKICAgICB9LAorICAgIHsK
KyAgICAgICAgLm5hbWUgPSBNQUNISU5FX1RZUEVfTkFNRSgiVjY4Tl8xMDI0IiksCisgICAgICAg
IC5wYXJlbnQgPSBUWVBFX0hFWEFHT05fRFNQX01BQ0hJTkUsCisgICAgICAgIC5jbGFzc19pbml0
ID0gdjY4bl8xMDI0X2luaXQsCisgICAgfSwKIH07CiAKIERFRklORV9UWVBFUyhoZXhhZ29uX21h
Y2hpbmVfdHlwZXMpCi0tIAoyLjM0LjEKCg==

