Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A5C6CA6002
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 00:39:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEc8j-0004iv-Pd; Wed, 07 Oct 2026 20:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEc8f-0004hX-Bc
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:37:37 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xEc8c-000824-2b
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:37:37 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LtwtX1346098
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 00:37:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 8Rh+yfMK21+Twp8R38b7YOL1KJyCqBmyFbRm4oS4gIA=; b=OVv329YrWwjzA76j
 yqiXbcssC6CjlLgH31STkaS3jMeL6A1ENQpvjSB0tptjWUyi70D7NAooRYqqb2Mw
 WDVmIQQuSg4GmIz6qg0UYjV+pX3Q49v5vJZ9oIcZTO/GGCv4jXcHgjdhQCLLvzLX
 fW2v1AGlQVqVNcHvSm9AeUciR3hoowvuUoHXAFparNVtLPkGGa6ruUie/XyIwVY1
 1Cg+YtboCo9rGmsQJpcIRpYPqGAaKJw83E1lPLw7/obGIOZx7ykwGmBihj7rQDv8
 NYFBWHthsjVBUoDHUjYCDUnZBHID5gjwiPj5y3grhClI/H8QLr40ma2MTp8f00v/
 8DNMwA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe80dew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 00:37:33 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3510a481ae9so8978173eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 17:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791419852; x=1792024652; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8Rh+yfMK21+Twp8R38b7YOL1KJyCqBmyFbRm4oS4gIA=;
 b=NTMBTmeYz3N9g/NEoEOfRulvR5+a4vwXV3gaCJCLnfbk2rG2SUoEdoJOWTAilP/apq
 qSiY6rZccHS7JlB6C2/WMFQY3f3C6SMebcW5eeB2sTkhbgCYVIe2yXShB42tGVZFUM36
 5bPte2dGCXUQIxwYtkLSSHzlQxpXOBoTG7TVZHpIr3Hn5iE6VD//VjweqeW5FvNZ1MfX
 WQLsQ6x5D7bKbm4LE39B7/EfPFW3e7KciZtg5N1hRL4I5OOFt50KxtuyoAGqRX4uY1Jt
 p4l/WdFtzPHBqgwa1YAH7EXx8Dfxr5Au6ZTbuUVmo7Mxcuf4zaVTMFfIobPooWFz1PEW
 wA7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791419852; x=1792024652;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8Rh+yfMK21+Twp8R38b7YOL1KJyCqBmyFbRm4oS4gIA=;
 b=VY32hiaK7dU2q7mV8K7s6LN8juDBTO/RAEyweVG5/SZpfqRSQ487isKsXU1uqGG2KY
 kQ+ZKP/sZHjSOLKeyFy2TC5v/k04D26EOTjI5LLX+PXFQcRnzX1nvujOLTfgU5FGanK7
 BcMMyPSUJqjt/9dziIzp2ssWgssfpiUHyVEUF/NcUd3YutPKTaQW6iJu+V5mXVbCesnp
 2qpX4OcyjvCB/2EEpTKGMDdQzhUejWk6Q79jq5mfkW+37J4EglqSBnMdiOhPa27jvGDf
 BnRuR5mbaNf9enaAdaZO0JUS0Cqb2km4ue68c1NPvP5f29finEqeJP7qr2jl6OFCo8hS
 3LHA==
X-Gm-Message-State: AFuF++kVAkW5JQDvNZtinWvjRbTH0sVxg9+ltvLqjrXp/iXPR/wATRLc
 zDi2exg4Cf6ZSdOTRlomN5lGDCNRYuondDycT6QYm2VrBNt/ZmT7Tm7BUfF9m7WV639O2+eEw/V
 hTZP0D9agVWdHoczwbwL8S+eN5rNjAjJevJqch2sErme+ROvgQGrvObZWF3SDjTQZ9g==
X-Gm-Gg: AYBFou0hUc19cXsV4PUejtmUypuhvdNFWxTmTOYjkQP/6AuX6TWy0k3plUDAe+E2klp
 X461foT7FHWL93KxBTTVYkC9LCefGdVbI4HBNbHZ96Voe6ct0CTkDKyYJv/XcaFVk3U/jPdnltt
 WjISXOtoPj1QbrMoXE3KoRIDks7ZJM7TDaAPdcXt2gC9TwIY9x9VnA3QlBXlGtAOVYwjQ7it1n1
 ixRbs4bIkIRReo/2fBdDGyncLzsWFLbqfSxhBz1fnd0Zjf+VWyKWry2EAB+p42WpHJEMpKorpar
 ZKcnKyS7D/ZM/gA/5q0JSzsqKirwibjWgTPfCp42mw8FwULAeAdOdUlGN7eqrzukJkPASAvz/Is
 FWB9F0bhTBkYCHAGJUHuxZJiVpZ9rS/kzzv/Y2sNBlUdb+hg=
X-Received: by 2002:a05:7022:4b:b0:164:ae59:935 with SMTP id
 a92af1059eb24-164ae590956mr2450892c88.34.1791419852146; 
 Wed, 07 Oct 2026 17:37:32 -0700 (PDT)
X-Received: by 2002:a05:7022:4b:b0:164:ae59:935 with SMTP id
 a92af1059eb24-164ae590956mr2450854c88.34.1791419851524; 
 Wed, 07 Oct 2026 17:37:31 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-163e3c5bed6sm4380048c88.7.2026.10.07.17.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 17:37:30 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>, richard.henderson@linaro.org,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 marco.liebel@oss.qualcomm.com, Helge Deller <deller@gmx.de>
Subject: [PATCH v3 11/12] linux-user/hexagon: add v75-v81 HWCAPs
Date: Wed,  7 Oct 2026 17:37:10 -0700
Message-Id: <20261008003711.3984454-12-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
References: <20261008003711.3984454-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMSBTYWx0ZWRfX+nuEyoViAz6r
 Yta885r70PIPSlRhqFBCIU2gya/dLvC0+xck7cyfcDXNiRyHL+b7c43/wa0fH/ai4Iy4gPd7D94
 ErPPOjyrXM9S/DpUDIB5XeM1+UZ6PDMbdJN80VpUFSHcmZdbG+50MwtY+bKW35GGOOmYMfkZOA5
 3buU2glMACF3oW1KTI5+9IL6FEuzods4VjPM9Ebc2lBe8wvRF/+1LhIPXj825q8ixnJ5R3aunKZ
 GiqQU6jezgkSD1M1TavJzFxsrcSX1p/SAlnhvnB+u50djaw6TZoRlJ7HtK0ahvXYgfSc/YR6z5q
 N1a5ktrq2NszEynjdMXCpk/Hfgv+OfXWyxgu2HcMcbfC4PTyBLlTYRHWv0628Gbtl+yGMEuATGK
 Q7POIwPHJVa09Bri1Dulwo7qEN2Qksjz9YRvpNNyQDO6SpgyEwhESgLR2nU8xppyA/KO4PoPleZ
 VqZn9LeU/zQxmKPOX4g==
X-Proofpoint-GUID: a4Qo8S6O3ZdnCgpjozG2EyQaqm2sJiaz
X-Proofpoint-ORIG-GUID: a4Qo8S6O3ZdnCgpjozG2EyQaqm2sJiaz
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMSBTYWx0ZWRfX0VkxRXGZu0/G
 SgVbqqqp9vCqriELaW9H/NVvNL1JRJ5TwTrc5+xLyNwtP26JUS57aDdRFzUfCxFRPJt5jM3T5pG
 AMrxipoGZWhimQfFBhz3uPdG6BevyVE=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac6e5cd cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=BRFeZrn0LRIrCjf-XoEA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080001
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

UmV2aWV3ZWQtYnk6IE1hcmNvIExpZWJlbCA8bWFyY28ubGllYmVsQG9zcy5xdWFsY29tbS5jb20+
ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4K
LS0tCiBsaW51eC11c2VyL2hleGFnb24vZWxmbG9hZC5jIHwgOSArKysrKysrKysKIDEgZmlsZSBj
aGFuZ2VkLCA5IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9saW51eC11c2VyL2hleGFnb24v
ZWxmbG9hZC5jIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwppbmRleCA0NDA1MzJlZTQx
My4uM2E2YmE0ZTEzMDQgMTAwNjQ0Ci0tLSBhL2xpbnV4LXVzZXIvaGV4YWdvbi9lbGZsb2FkLmMK
KysrIGIvbGludXgtdXNlci9oZXhhZ29uL2VsZmxvYWQuYwpAQCAtNTMsNiArNTMsMTUgQEAgYWJp
X3Vsb25nIGdldF9lbGZfaHdjYXAoQ1BVU3RhdGUgKmNzKQogICAgIGNhc2UgSEVYX1ZFUl9WNzM6
CiAgICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y3MzsKICAgICAgICAgYnJlYWs7
CisgICAgY2FzZSBIRVhfVkVSX1Y3NToKKyAgICAgICAgaHdjYXBzID0gSFdDQVBfSEVYQUdPTl9J
U0FfVjc1OworICAgICAgICBicmVhazsKKyAgICBjYXNlIEhFWF9WRVJfVjc5OgorICAgICAgICBo
d2NhcHMgPSBIV0NBUF9IRVhBR09OX0lTQV9WNzk7CisgICAgICAgIGJyZWFrOworICAgIGNhc2Ug
SEVYX1ZFUl9WODE6CisgICAgICAgIGh3Y2FwcyA9IEhXQ0FQX0hFWEFHT05fSVNBX1Y4MTsKKyAg
ICAgICAgYnJlYWs7CiAgICAgZGVmYXVsdDoKICAgICAgICAgcmV0dXJuIDA7CiAgICAgfQotLSAK
Mi4zNC4xCgo=

