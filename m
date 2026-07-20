Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61D4C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 19:36:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wltmn-0002aL-I4; Mon, 20 Jul 2026 15:36:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wltmd-0002YS-Tr
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:36:13 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wltmb-0001ra-JY
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 15:36:11 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KJTgNr3753485
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 19:36:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kTLD48Da6jzMalCUyQyUrF3m78rt9gBy3YdPmcbgc2U=; b=f0wZBE4g2fD8i9IU
 72sH152ys+QsHtznOgQOuQZa4519gAeaXGWlyJbR6tbfTlC/WQQAYLOPyNnmtS/c
 I4r7dJ0mS17dXvM5tTlRY1lGNSMhZI01w6Y+vA1+5ILCSiJqr6fGyD0rRJT/UGG3
 AHXx+Qd+8Rjna5KJ5vRv143u+95jv3U9XfZdVa6zzUWxjS2yzanBoBW95n0wqgGy
 sQE5D3O+sDn5NvsSYoVtaNoIbxWS4UFO4Cbnn726ttCo3QNn64K5sTziFwpogGqv
 7lodkg6L4gG/6LBDxX9QWl4x/VoYOUE76lEbloXQV+94TzRLSfL9iqNaHxJ584l5
 DVdGpg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhqv5rkja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 19:36:07 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cab3e9cd922so5475587a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784576166; x=1785180966; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=kTLD48Da6jzMalCUyQyUrF3m78rt9gBy3YdPmcbgc2U=;
 b=aWiRG+d8oqgBqb+UyF0TBay4DPIuW03Ma2gQuwz2KwLF123DShVijbHp0rBj2dfeUo
 +H4chxzOgFEyaqUnY+ZAMH6r1RZYfDL7vNob3nIjeQtWx7+Hz8mU2F1Uo/GmOul3e54y
 bGQoPGDqPyQk95deKoZY18GdPoyvlcEfPOPzjkNoeic6ipkAbHAhh/ugE3wlxFSjIeez
 uZJcWH58UKiCFu4iPlMK3saTbuqLv3yg7gK1TwInZyT1BWTrPuxHI22esLJg7foKNgYW
 0aLZAdT4RYSuwGgA3RQvLrEbP3Pn/DXWQjNSAk3CmAoO/3c3Y3jkc6tY3Q8RSaHUu1hk
 Gkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784576166; x=1785180966;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kTLD48Da6jzMalCUyQyUrF3m78rt9gBy3YdPmcbgc2U=;
 b=EQJQ+AXrrixJwgR6PHYw6X1dHoe+Kc6rDElkgfnKWF3z1VNAmUPsihYtX4c6KrsYnW
 VN7rfLFLvuM2OEHYkE9ns7YFOBXCQ6/tASO//7SgJjz5i8V/KCYIhtXasUg6ZaVN4wPi
 NocU5Oobr1Mohz5ejeqJcu5JI2TzO4NChLXpjWH27XvokkzWrJCKoW6jYxdyTK4B2KEY
 +sv8dppj2xKr7AqkP+sUxAPpH3ienizFUUBduHC7TTd7vJQKgE1IAjTMfac25oTJNnky
 MxRf/51B3Y3jjdMiXSR6PmA5nkEu8Fi7tF02owTgcnSV/JcZYlkV5u/3rwnn5WEmMJFe
 JbaA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqyDBLib4AU0tj1HoOpdL/B/G9qDEmXE6F8oltavrJ5f5ShAyE89PMg1xJLDZpyFLa61LVF0VuieBxv@nongnu.org
X-Gm-Message-State: AOJu0Yz4kKxCcApwDxwzM6X81OERPIQn2KG0Vqc65oNqBuMlMAPd6mV8
 8Qwb0SD1l2Qs0Z6OsXUUxe8lAynjQVWFyTz9IRQ865Jd2RVy3ZzmJlc1bCTi9peFunPS4tGULEW
 txJIofQXJWXzeGRK7c34P89ceuCO4Nur3rmihDxcV2aau5m+psd0oIz50Xw==
X-Gm-Gg: AfdE7cnMoTM0NBso7Iu9pEd14CO5GTe2NOV+lymiQ1xk6ulZ4JiRieKBHBKFpMMZOUY
 FKSegiJfKxk1mxmyh1VjPStKLANVYcZ4C6/lrzTYKXB1iqIBEDiFLmrCzDHrNambZKQX6Fx2q++
 qt6ioGcFzrIF0QTxMz0eB/Twg5epDJE+jqSLQKxzh61t4XYTcx9NaZ1twSs2RNm+H2iLLLmszxT
 50y1eFTcnpksk0oms0toF8Y7QgTj/aXs5hqGtz/aBb/LGiWocE0UzuSQr05vUoALjIS3J+H0DhD
 EZN2dKwvkxyY8c4Pp1KgZGpy/qEAl9EGQ4QmkvWBukc7b/0lSGzI5MvVGI1EkzrzIXoRljmq2Mt
 NHeVcLJsaxlH/oU1bH16cU1hEBNqKe1fvQuvXXVcYJJW83qW10E8Yp9e17FbyAX16d3cd
X-Received: by 2002:a05:6300:95:b0:3b3:1b38:d9d6 with SMTP id
 adf61e73a8af0-3c3ad9646f5mr15283046637.39.1784576166446; 
 Mon, 20 Jul 2026 12:36:06 -0700 (PDT)
X-Received: by 2002:a05:6300:95:b0:3b3:1b38:d9d6 with SMTP id
 adf61e73a8af0-3c3ad9646f5mr15283016637.39.1784576165851; 
 Mon, 20 Jul 2026 12:36:05 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1ddeb6sm44452879eec.20.2026.07.20.12.36.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 12:36:04 -0700 (PDT)
Message-ID: <5f31d663-dfc3-4173-b356-562e020c0067@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 12:36:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] target/hexagon: fix ciad assertion
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: matheus.bernardino@oss.qualcomm.com
References: <20260717214534.1203949-1-brian.cain@oss.qualcomm.com>
 <20260717214534.1203949-2-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260717214534.1203949-2-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIxMiBTYWx0ZWRfX5cRZ+W+gX83e
 2y9Td1D8Aajt03wWzAb+L5K3p5vKVoXy/Zdbzyast0COiA8koGkD0XujpJnYc8yJDtIamO3caQd
 Q5Z/BDfPRBs/U9Y2W0VX8XEeutLJzmy6h0GIqCReyfeq3QjAUyDc5Oc2xSSFqvdna5E+NwxDhyC
 QDZAO3ZlVptvPWG5pCom8FnWzW16Ks4SlzuTE1XSuLlQSp96H3xCufVDcA2WWd+cRDDxtH81hUY
 igsMHIXsvUUprxJ1w9y3RaktbJj/v8FCwLgV6UItxu73Z3ACEmWV2WmDp6xqpGeVZmFnERsKsn+
 I9aFw6NMjWVm/kZ2qtlUFamby3Oytu2PFrdW8Z4ptbVpMRTJDol50oVDbB3B6QgtNoneMlWFNHR
 +RS2kmwhbA6JTj/J9fwVqNsWZlJ44kHQGB1AVRe75wpA8F0nGq19HxNEUh5EuXVCSlhZw8O0mYV
 NisNwuRxipIB8SnuKNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIxMiBTYWx0ZWRfX2uccPGlt1RN6
 RDNp1s7C0QvmEnyMdqoUAoXt3XTqwhiYYU9TOyJBiL7T+jjsT8qR0IW4apgy2ijTgFXv5Qc96dL
 z3G82PF9HrhFL5qVzGjGwXUlAMZWcxM=
X-Authority-Analysis: v=2.4 cv=WNpPmHsR c=1 sm=1 tr=0 ts=6a5e78a7 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=ZHg6wcsnARyzKXisT8cA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 1xetWPHLZINajFJ7e6RDs9nb79wH2vZG
X-Proofpoint-ORIG-GUID: 1xetWPHLZINajFJ7e6RDs9nb79wH2vZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200212
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/17/2026 2:45 PM, Brian Cain wrote:
> The ciad helper was a stub, so executing a ciad instruction aborted QEMU.
> 
> The full ciad behavior also clears the pending interrupt in the
> l2vic, but the l2vic device is not modelled yet, so log it for now.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/op_helper.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

