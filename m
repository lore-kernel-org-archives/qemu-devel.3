Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56751C5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 01:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwV9p-0008JL-0g; Tue, 18 Aug 2026 21:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9o-0008Ix-5X
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:31:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wwV9m-0008Ce-JV
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 21:31:55 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INkWed3326037
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OD/FOqXE+hJJhm6kWRnIF2G213YDoLGg95OEhWNzAcQ=; b=NOLzZjZ5HZtStwhD
 QjSLzAhzuYEGTBKBl/snhEq67Dn/j8vJFW2D9QYWo2tfFgivJG2S2Nsp/IBoYA71
 dsXygdGB5YFM5QG82LqvqKQ1CdPZOie/ZYaDwLGC+xEtXIHLKNjiw1DserMvA06+
 xeUh4cuWjHaRKf4hf63zLtmblUVxUuSeDe/C3d3d/PHfsXZf9f24nd8pC4T/2cWB
 qxz28qaQuijVTJrhPTHX2M3dUz0foFN7xHKlgJgHAG+LpAXoU+SXl4dbit1VoUPN
 bY8GrKo+z4YwF16nQ+MVWgJHyR5udQ4Ur4RNJXgL76klaKGY4Ca23FOcP55GAM13
 XMu6FA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfprq8q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 01:31:53 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-388b404eaa4so898752a91.0
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 18:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787103112; x=1787707912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OD/FOqXE+hJJhm6kWRnIF2G213YDoLGg95OEhWNzAcQ=;
 b=YmEn70SWTTXXkjkVrYE5Yx+FBem+IK0/Ku+fKYFWw85nWP9KpOEl4QQoi5dzl5V3+L
 sJGtu5hOFp9YdAWPo3mn5odgNOuRdFyY8vcYYHTbQxBFgpimENaev1HaCAu+QNbTn+Yy
 VV9CVXv7Iw7pBKOMkQC1qkPdgFM7p4SQJCNXKzDaJhVdk/c1eTdHkKusUyiHYDUTGHPm
 qJKsDSJqPMUteXF6sCp9MZmeLTf6sGmb39bmTUZnG/rrwmNyBlIVPrlmwS8A1y6DS0mW
 ikLLWE0S/r9e5oOt1ldgNNwyTfdzKnNIdBF8VZbkNVMFX+Rs/BjBDY2HrlH8X/7HoWPU
 76+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787103112; x=1787707912;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OD/FOqXE+hJJhm6kWRnIF2G213YDoLGg95OEhWNzAcQ=;
 b=hqjKb3LTYXENBc18LIcJytWYfIkYPiB1ln0hYK+sVWJJiSZL2PQdblSuydZCSe8ng0
 ZXFadsSQDYaQ7asq7I8VMOcnhiuwLU3bQKjE6VhGWVjnlvptSi+5FI0//UOCPXSRIw89
 UAHCjZ9OqRGME/9pFNOZuNo4B7VKAYOCD+TQ90BOewLmvDAZT7F86EPFW0UB2NO2wsim
 eALWLWqu72kOfvh7MwNofwOq/oMHxFVTe760HkiTIidguPLEfXJ1+8YrnzZJ5sucNxNW
 xYLIMIO79i2d0g5sntg9dty2Nm7eiwvHtrnF6tIRKGO1m9YvJ0Ww99iRBKyzRPCQQTcj
 4KdQ==
X-Gm-Message-State: AOJu0YzFyCPlNOALD2O1ABtU8diOhkhSdxLgqMuxMSP/1rS1b2R2wYca
 j6ihzsPTTIIrxgUZ+kwqvpKoriBrtbJD5gwYb0L5XBY5TyB3WmEGwPNW0ZoQM/etTbtdS4VZBlF
 Sxep/gJvSf7NC5S9vy1ifAVk25rgKYRxKhSoAKAWUw+OYkg1CiEM2YV0E5e85Hxwbzg==
X-Gm-Gg: AR+sD111O1TBUSDXeEViB7s0Lj/pFwiEus/D4AXPsBPjePCyHdW/o61HEto9+vzqm5y
 WbbG8B0n2Gaxm+g7bCscmi6nVKDXXljWFC+JIicG+Gnm4ftXXh2BlwRdkmbOT0/cKV9tZcdfdIV
 FACGTshwGWHfx0AMZuAi6VD4pTyJenMOKcF3y30blr80E5eBQbTfPHap91DtBKdoPLdbOECE4qQ
 CnJPHwlAssxegZCJIHztRu5iwqjcDVxTE4BbPnk81rEnq+9/uVP9slcoTCEUUyu8YnpwilkIaOE
 JOuvAO4NhWkIEoBrE7s2WDJQVo4bnth08Hreh921NEIOhRpbBrKDRt8V4hnAEd43SxKWNhUN0D/
 CmtzaxYur+RLUxfpzSQAah7NvL74O1cO+oezyIDwcFPvImnRN
X-Received: by 2002:a17:90b:5385:b0:38f:caa2:5721 with SMTP id
 98e67ed59e1d1-395812a8662mr1995291a91.17.1787103112475; 
 Tue, 18 Aug 2026 18:31:52 -0700 (PDT)
X-Received: by 2002:a17:90b:5385:b0:38f:caa2:5721 with SMTP id
 98e67ed59e1d1-395812a8662mr1995205a91.17.1787103111982; 
 Tue, 18 Aug 2026 18:31:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327befa4b94sm1157539eec.13.2026.08.18.18.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 18:31:50 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sid Manning <sidneym@quicinc.com>
Subject: [PATCH 03/11] hw/intc: clear pending bit on l2vic de-assertion
Date: Tue, 18 Aug 2026 18:31:36 -0700
Message-Id: <20260819013144.3264096-4-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
References: <20260819013144.3264096-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: 5q8zc4y_Vc3RW3G5d2NTdjwUca-_d492
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX2aILZe+IPPxB
 dw/LXXcUy/shU6Ep521FNIpNH9l5IW2l4QkEbLqZ+uTVuYjd3aIr2R0Jy/4wp4HaOj6b8SwFGu2
 PgRKL0Qb7haP1sTVLeOBIU61GTEuFIEjyI+XNpMvIRGy2aj/SjebgQKdQ5YxaADcxNcI8U4q9wr
 MC3hPsg11dz6rAssfCSYH638s98qwlEz9NrIF1gjYxqVDZqlRNNC1FOxgrIfTNaVWjNrIFAiR9E
 vBmAuiyj6fSvuoBRAjJR+BeHz6riuAyP4HECjpPU+IDgGyi1E4bbfCTQVPhh4xI7C3DjydG9cCQ
 Dq/2FMv3H+/ki4ZfHBtfK+6U2jmBx5MOhZ8iTlebslirVpGA1hD7IRclcxKn5GrWurbvpKU+mGD
 i0ZdXIknVe9UDCKJjlDnhWjUdVZIGM5VyIRUvLlGwuq3P/LJidMn+aBvY7Vn10jnbibAUifu9Mf
 JnCsPAI+YF39hFcIuUA==
X-Authority-Analysis: v=2.4 cv=aMrAb79m c=1 sm=1 tr=0 ts=6a850789 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Z8PlLslTYKWvlVeuNugA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 5q8zc4y_Vc3RW3G5d2NTdjwUca-_d492
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDAwOSBTYWx0ZWRfX/z5M5mmsf6cM
 0U+qQ1dDStTSSsqB0LzLvr94qWoOpJcqC4gE7m/AipCF/icxeMjYXwvk1i+ewuoL1w3seSklKXm
 JVM70Y5evQOGOke1b5klnzG98/NumHA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190009
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpsMnZpY19zZXRfaXJxKCkg
Y2xlYXJzIGEgbGV2ZWwtdHJpZ2dlcmVkIHNvdXJjZSdzIHBlbmRpbmcgYml0IG9uCmRlLWFzc2Vy
dGlvbiwgc28gYSBzb3VyY2UgdGhhdCBkcm9wcyBiZWZvcmUgaXQgaXMgbGF0Y2hlZCBpbnRvCmlu
dF9zdGF0dXMgaXMgbm90IHNwdXJpb3VzbHkgcmUtZGVsaXZlcmVkIG9uIHRoZSBuZXh0IGNpYWQu
CkVkZ2UtdHJpZ2dlcmVkIHNvdXJjZXMgKGludF90eXBlIHNldCkga2VlcCB0aGUgcHVsc2Ugc2Vt
YW50aWNzIHRoZXkKYWxyZWFkeSBoYXZlIHZpYSBTT0ZUX0lOVC9zZXRfaXJxKGxldmVsPTEpLgoK
U2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgot
LS0KIGh3L2ludGMvaGV4LWwydmljLmMgfCAyICsrCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvaHcvaW50Yy9oZXgtbDJ2aWMuYyBiL2h3L2ludGMvaGV4LWwy
dmljLmMKaW5kZXggZjA3ZWM4NTBkNDkuLmE5ODZmMGJkZjM1IDEwMDY0NAotLS0gYS9ody9pbnRj
L2hleC1sMnZpYy5jCisrKyBiL2h3L2ludGMvaGV4LWwydmljLmMKQEAgLTI5OSw2ICsyOTksOCBA
QCBzdGF0aWMgdm9pZCBsMnZpY19zZXRfaXJxKHZvaWQgKm9wYXF1ZSwgaW50IGlycSwgaW50IGxl
dmVsKQogCiAgICAgaWYgKGxldmVsKSB7CiAgICAgICAgIHNldF9iaXQzMihpcnEsIHMtPmludF9w
ZW5kaW5nKTsKKyAgICB9IGVsc2UgaWYgKCF0ZXN0X2JpdDMyKGlycSwgcy0+aW50X3R5cGUpKSB7
CisgICAgICAgIGNsZWFyX2JpdDMyKGlycSwgcy0+aW50X3BlbmRpbmcpOwogICAgIH0KICAgICBs
MnZpY191cGRhdGUocywgaXJxKTsKIH0KLS0gCjIuMzQuMQoK

