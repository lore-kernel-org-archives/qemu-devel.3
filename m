Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5893C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weBo3-0005eR-HQ; Mon, 29 Jun 2026 09:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo1-0005dQ-W9
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weBo0-0003Hk-CT
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:13:45 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAStsC2640788
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=; b=hv3usuRjHooXKcFT
 zFpOyt7tATvqcfuKYi1oIAvJ+T1V3ru44jxclIxbql2UQBQqFlPZBBpW5Iv6IY6/
 YSmxKKDGrofaAtQeOjUMkGTIwst2PCpcXPRp9ityo8YY+10xqJrslJqIhe9iAUEt
 /0lLDPl+fgfo7esQ75Ya/im0MR9Tc/PoJoKs3iBZIYiWMnoypLburhpRqR9Igpc0
 Ysyx1E+79t1K7kdcnkOtZHaHJLZPQZoOaqF5szu8OgYikzWymkxWpMwRheb0JS81
 C6G73ICB2+scj4i1fMSQFAkXHAXobRxjePzRRj1ujtLXXTC5xaUfksnDjNGGMe6N
 9Xb2jw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s144w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:13:42 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-139af2bd2c8so5630308c88.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782738822; x=1783343622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=VdXkiurpmY5bQ0fnfytDVxBktBixt+MvKDRm1W/hjPmTioeQEf/0W8u3127ZRl+xEH
 dxIOYQaW1572Q/Llqf8bPnbSgZV+tnmvYB/JVm0iG2i7DGZulhqVak15eccZljw/cY79
 At1QmR1N/CSv/W/PlSsmVtFV3W+53FYJbRxANMmoj0Oi7w9yC9ck4M2OJlc9oU7yIK8k
 x3KXWiNHgrYG+w0jG+zXPntBgJke9XlG+sp6cshSariZDTcr+eShScyqDBe7ITtGjhNs
 YqVVJKyMY+cD1ncanpHz8f+SfgIK24Bjf9LYhn1v1JaQWuNHbyO+xaE7iYjJsLUnKcgl
 GExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782738822; x=1783343622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=m5UU41xNXgOYOUhcsRM1Mbj6LjgiCb5BnAZI0L6+u7kYKcUkIrysflpcGH/0WEIC7o
 IltVhtjUK8RXpXSrKqeF33FgnCUJnLULU2PqkVUJ+74LOGb8N7/dy4d97dKVl1MwPoq2
 HSS3apuXgm87HtT1VpwxXCbKANzSX/lVRC7FJajzxrFvv6CY71uXbGQwYUXs0UUjH8Zf
 GDBBAG2V1gAooZ794mVuwDhfgs0nUXmFxThqLXb87ykgE9DiWNve+PK7cghlX3hNj1vx
 2YqMDv0svU5ZZoDy/e+DvFC+RyD1SVf7ZGL7C9Gi0RoVU0Ul7JZ6egxW9okf0y/LFEZL
 +QPQ==
X-Gm-Message-State: AOJu0Yzi3mUz19Qnq/lh0QOmLWX5rkg2u7IBbsmiO38RK/BNLCm7zxe8
 DJ5wxqKfxwQH+OEsClwIVRBz5QiLZXzLIkwTFCPRTsFkcyWCjxZutAL4tBHh+peW4RGiT+Lvxvf
 bzTBRH/FhVBlvUjUcb6c71CPO9bS27QADX3FlwG6VEzxlsxrocZdToPnGCTGzrgAkPA==
X-Gm-Gg: AfdE7cl9YuCOwM6gNX+MSBt/z+GGJL2vPperAMCVxGJKLo6mb8pRCxRzafPpt2gq8CJ
 icK34iJM+vr5XzJzEZX9NtpF8GuT6kn/X5YW/JgUuLdfJ7cIQnRzOtQcuRGx9BxtBkYBFUyjHzt
 3tSo3RROxgVaHVWofAZemlef/tR7kXZdCpQzOCVzdYunCO8RH0cvc01e3RhDvFD1KKh7j2RFumO
 U4DdDAKXxolM4hDuXl0GY4zxZmD4A1S1g+oqJpAAXKyAOuK6xW9QGK5mG3EizRfprSQrZ8i60wg
 5m+nous5QaP94vlcla4THlP5zQfah9jtFV7LA8HLDC4UT7VvV21va+FqBjXYItdDJukoSXYBhCk
 mxHmHhuWBTpp91rls5Z7m6YcGF1eot7UgwO0avtWALPQvF4nzW+R1+TIN6Og=
X-Received: by 2002:a05:7022:60a1:b0:139:ef82:f6fb with SMTP id
 a92af1059eb24-13b227310d1mr384962c88.49.1782738822089; 
 Mon, 29 Jun 2026 06:13:42 -0700 (PDT)
X-Received: by 2002:a05:7022:60a1:b0:139:ef82:f6fb with SMTP id
 a92af1059eb24-13b227310d1mr384943c88.49.1782738821521; 
 Mon, 29 Jun 2026 06:13:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e78317f3sm28459106c88.9.2026.06.29.06.13.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:13:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 39/77] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Mon, 29 Jun 2026 06:11:54 -0700
Message-Id: <20260629131232.2487780-40-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX55+1NG5O//UU
 OGhwre83hGw5UELYh8y/fQih10cELhyGp9NjAYE630D7LNGI2+1eQOjlkaxujUkYR/cDr83HN8M
 EUXLSFN9CouQCwW1CEjeOUppm3qc290=
X-Proofpoint-ORIG-GUID: AYomWXTMGZrBbL8ZqHpu9pAPWLzhfadU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX09EzS/u40DEE
 a2tWWNxGZDnjLDSmNDj46gIYkxyIaNi/21vIwUPfa8QRNWyVccY+VAkMdXI+gay5xJxdz0VqWbj
 qbLbdR5jnV9LOzkMJO0/7fR4nLCKwXBfMLhF6sPjeDMJQZQmM89dlsNTOwVre8qVAisZzwaxLCd
 NunG9zHZXPEAzTSewC02AqW+m1OJ5yUI9S0hDPAZiZoeJECUw0ajJzMxfXkGzARzfwOIeGOQLXH
 dBLZ72Ts5cyeApumWrMyz2Th/4SLLctTRkz7irUWQ41ugL/b8rq+I+ySgO1aYsWQEOcFROC7jHT
 Whr8aXqaWXY77wkkmDP1h+4erg88RBwC0yephiqwugFspuznr/QmxU6EK5A1hrHJXoq7j38kuq4
 B3rb2rk/NfLjAsj5r1qGQUBHA9NK76UwlH4/DsuxP6LK/JapuA3Mh6jjtHSiRjWQICB2MIpVWiA
 GFc5xmhnobxHnhadIWw==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a426f86 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: AYomWXTMGZrBbL8ZqHpu9pAPWLzhfadU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290109
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oCmluZGV4IDM4YTQzNjQ3ZGQ5Li4wNDFlNjhhMTUwZSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTY1Myw2
ICs2NTMsMTYgQEAgc3RhdGljIGlubGluZSBUQ0d2IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQs
IFRDR3YgdmFsLCBpbnQgc2hpZnQpCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9b
RklFTERdLndpZHRoLCBcCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERd
Lm9mZnNldCkKIAorI2RlZmluZSBmR0VUX0ZJRUxEKFZBTCwgRklFTEQpIFwKKyAgICBmRVhUUkFD
VFVfQklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0u
d2lkdGgsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0ub2Zmc2V0
KQorI2RlZmluZSBmU0VUX0ZJRUxEKFZBTCwgRklFTEQsIE5FV1ZBTCkgXAorICAgIGZJTlNFUlRf
QklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERdLndpZHRo
LCBcCisgICAgICAgICAgICAgICAgIHJlZ19maWVsZF9pbmZvW0ZJRUxEXS5vZmZzZXQsIFwKKyAg
ICAgICAgICAgICAgICAgKE5FV1ZBTCkpCisKICNpZmRlZiBRRU1VX0dFTkVSQVRFCiAjZGVmaW5l
IGZEQ1pFUk9BKFJFRykgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

