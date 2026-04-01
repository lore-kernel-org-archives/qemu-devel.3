Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DC810F6FD9
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 15:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7xVC-00025W-5T; Wed, 01 Apr 2026 11:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xV1-0001Tb-IN
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w7xV0-00084G-52
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 11:28:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 631FPfdu1562478
 for <qemu-devel@nongnu.org>; Wed, 1 Apr 2026 15:28:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eaPTK8WsZS63Nq3x835Dlm5fZEwFXHAh0ADELEtS9L4=; b=iDr/ObEtpRxcxq+M
 BvjRO9qjGDSx67XZm95z47OO6bAkvCj7K0zr9LkyEk6BNlCIjKrIGDmB1hHgQ/Ik
 otgRcX02K0BE3k/OdyptZxxMJzmb5WrROV953g/dLekmqa8Ip8MXy25aU6etqNUH
 8i/p+aAtm2PiXLodbziOQ3mxcd51Jl1Vsjf24W/Jl7okSv3mpSmRoVsgGGByVLsc
 mgl7RHXvdw4QdC9Iwt4d8YDyP1MYLTG1c90OPuWripTIDZ2fxKkEwKQwaPjGaj84
 ZoC79VzypUX4lPrM9pyQwy1Hbl4Qj5sHgr5FtYWk6tqUMpmN/7godnDfgjlpoSOh
 0EHfEw==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8va3tpvt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 15:28:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2c5b48baf75so8791429eec.0
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 08:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775057270; x=1775662070; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eaPTK8WsZS63Nq3x835Dlm5fZEwFXHAh0ADELEtS9L4=;
 b=Pu7GMdr7GXkS523/gOSIMJzvYbF2AgG7USxARJd+E+92FW/M1iFPysuLMpBw7H8dgd
 KPn2yydCOLSQCQdxMrzMCvXN31JbYX6fqf/jyq3FqV0ifgt4n6zIiB9LYh3woR2hYtF0
 CDdl8UzZIJCzakeGjikXAT//+f/T79e7zwJpcKwORZrm4meXckTteDBM/YPKNrKHyu1Y
 uEDzde8yO6mZTd4kOOaB1GdTnJ6nDMmTpjFsR473ieygBSgkix9gv2Q3V0f5jTFY6y7K
 5kVKtwYWkq13OFCRNq52HGGvND4KaZ6nhPLodMBcXal5Og7R39S8LSrsmZAansskYSEE
 iFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775057270; x=1775662070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eaPTK8WsZS63Nq3x835Dlm5fZEwFXHAh0ADELEtS9L4=;
 b=g0GlYG7dLObsHPZy1tzb4KGY8s83md4GIJushDba5c10BbcKPavaZSY8Rbx7J05V7i
 SZXsxjmRPGqctYRq9PYfhB0g3tUNE9jsYZTAfoiVIn0joTnaUpa6g1dXEfK2f49rYNna
 Qm7y9sef5TBkiSgdc4/CgL4uEqZICbdJ6VtqPdU13gLSjF4weYPL0OT+zGsO+lTAZv8l
 AZajUh25K/1Q14GzNs3/qQRQXURb8/cRbgLdSUimggUrRatAa2oUBqY38ACJxKuKZMI9
 N4uHSnW5lJQql7U1bq7DDOHqT8yKBmcBr/dKzNFIEb7vFswtxqvRM68OYAe7QQjOpxI5
 okmA==
X-Gm-Message-State: AOJu0YxKxL1/+6rJqqXtD68zzMgqglmfEcrkTGvV3BkC2UmfCm2Hvr5o
 fjP/YC4KZdP/HEG50zLO10qZ2uyj/U01qAqQHz4AhXi2ZM5yBzg0qLVVEpC21/UNni6KyEGvXRq
 yEjIdAZYPVTbuSknwSIPdWd6h59SFwcrwQa5nEUTt5MVhDO4sd7Jtfu5NpvD2TkZJag==
X-Gm-Gg: ATEYQzyEzGJyW9QA5bLtLE7VBQoJIPCKfZqsa60fKl9mHdzqNfKL+0q2fdiJCnAbxDm
 aj9IsTaHI35I4voV7t46V2Ax73qiuue1Ixx+r61Pm3IiKTVZyB9p6+coDVdYAEq4OqdkeL79BgN
 tcGMEnk4VhKKlNp3+VPNuXTEVp6LXFZi5wdYGKN5JnWO6RnguA5JE4xCpI60rU87DmGj59Z9iEN
 DnQCsWM6ZifAhUN9AuHeEsZ+Sz1CjY5KQBNZPOhmK/SouYJB/FMPXIGiCV/AE5bZARwmpMzgEbx
 6hHk7IDcuw3qV7BIc9DnILCbLd5erIe6Tr8k4ZKPVo03WhkHw7g3+vl/RHjzVJFLyal8fPIWC+/
 ZrXPtkxKhDOvkFKEtbwrxvgyBohKbnlCCZgQQZ1UrXTdcgTC1SR/nKBHcpgpgPCFlGFctAA==
X-Received: by 2002:a05:7301:fa0d:b0:2bd:c285:2fe with SMTP id
 5a478bee46e88-2c930e6bde3mr2220609eec.9.1775057269626; 
 Wed, 01 Apr 2026 08:27:49 -0700 (PDT)
X-Received: by 2002:a05:7301:fa0d:b0:2bd:c285:2fe with SMTP id
 5a478bee46e88-2c930e6bde3mr2220589eec.9.1775057269123; 
 Wed, 01 Apr 2026 08:27:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ca78df3b84sm38491eec.5.2026.04.01.08.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 08:27:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 04/37] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Wed,  1 Apr 2026 08:26:24 -0700
Message-Id: <20260401152657.314902-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
References: <20260401152657.314902-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: dhf4f6FNr1d6Qzv7I5w4AlaXKUcFyrWo
X-Proofpoint-ORIG-GUID: dhf4f6FNr1d6Qzv7I5w4AlaXKUcFyrWo
X-Authority-Analysis: v=2.4 cv=B/C0EetM c=1 sm=1 tr=0 ts=69cd3989 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=QFI6e2jESK29WoJ26_YA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDE0NCBTYWx0ZWRfX4dSCzzj8EWXI
 WBL4XXunxO/27+ie4Kpd3uueA3ZmingxBwCqZWZ3QlP9NKSApfEI7kIf9lcZkaYqMkaLy7uykKa
 68UguXDQbAnAuUNQ1wYnp7JQb5X6TJ1AcdpF4lY7ctY2m7u7LCL7xLcOseqoi7v+VhFTN568We2
 GPXV3jBwTFSFH724ljwarh/0csG9ckkqS2JCxiPOaOiiZRA2rupOZjQ+yJ8BMsC3T0VMdWKI02K
 3OgClwi+7/7bErQvJiCmwkX4YwepnHtaCnXRP4O+itILs2fCid1xyr1yipnVxef+g76TeQvTF8w
 YL8TuHAYSK5kZegFzpH0xU1dTA2SUjX/kxNkw/8SNIiZXIxXtwsvXMGV9IsPKN2R86KL2BpsOfH
 XaYda7eLcBPNUNd6EPJJJbFK5UEXK7cpM+YHeD6uh1N4BD4fRwhxG9bKjx7Q2iCanjRQxjisI9i
 vpEzlMj3mI8ddUXuP4A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010144
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5IHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBi
L3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKaW5kZXggYzBlOWYyNmFlYmUuLjAwMmFmY2Ri
OWUzIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2hleF9jb21tb24ucHkKQEAgLTI0Nyw3ICsyNDcsOSBAQCBkZWYgbmVlZF9uZXh0
X1BDKHRhZyk6CiAKIAogZGVmIG5lZWRfcGt0X2hhc19tdWx0aV9jb2YodGFnKToKLSAgICByZXR1
cm4gIkFfQ09GIiBpbiBhdHRyaWJkaWN0W3RhZ10KKyAgICBpZiBhdHRyaWJkaWN0W3RhZ10gJiB7
IkFfSlVNUCIsICJBX0NBTEwifToKKyAgICAgICAgcmV0dXJuIHRhZyAhPSAiSjRfaGludGp1bXBy
IgorICAgIHJldHVybiBGYWxzZQogCiAKIGRlZiBuZWVkX3BrdF9uZWVkX2NvbW1pdCh0YWcpOgot
LSAKMi4zNC4xCgo=

