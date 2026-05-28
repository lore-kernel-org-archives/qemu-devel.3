Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5623CCD5BD5
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 19:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSgGf-00046E-Gp; Thu, 28 May 2026 15:19:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgGV-00041z-Ie
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:19:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wSgGU-0007E7-2r
 for qemu-devel@nongnu.org; Thu, 28 May 2026 15:19:35 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64SHFTd9566549
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:19:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VUju7NYAGpeW+l4So1GiQZ2P/gBnIVrT0IrmHpAfntQ=; b=ZMpHVLUBL82pmjwB
 /KOq25YXbQPacrQqMKM6gQYuoszGhSE/JN50UUOZbo5XjiWZ5+JfCKqzxxdocHJy
 WFy5nxp/xinyRi1wkehKCEzEbIu5hkn0rBdswO0Vp+W4bnpj9U5/fxqICYM9N5KG
 p5aLn9lhoTAeOBpQGTKQRp37fEeWVw3CmEIGpEqk0YcvX7D6Mhcs8879SlV6LQJg
 9G3Mckql5wz6QClfYJqZEdC96QTj/qq/qEiORsBOX2MOz0Zpk+bLsU3GzQxVEdIk
 znQaaEdCLlfNVAv2at1juJGPPpQgeRLSJPc0llowZ4KHmpEhKNXLRuK4FhgNbGxk
 aYmrKQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynmdxr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 19:19:31 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13509e2e47bso16796758c88.1
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 12:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779995971; x=1780600771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VUju7NYAGpeW+l4So1GiQZ2P/gBnIVrT0IrmHpAfntQ=;
 b=Q9NbKS62uvlKsUSd8KR9k/K/YztyRQqgauTsUB0bzBLSO3LEUdC7a9AI2nY1kB2KYI
 xye+z7Q+8n0ojsEbv2wQcMW/V1Wl7mzkJrd+0LAduKN6JQN3WB+3iC1VGzSSnic7+z0P
 OQRakypAXz+2G6Z0yzPYT0LrQTmxJNPmZKvEE0GIUZ9O1P3UoDDOX/gYrjHGOXBe4+Fx
 EMpbVDm0Q3aHFMoIPR49fGQ9UW7i1IyjUDAI7YlJ1idIhxrc6Tmsy/+o9yXuY55fFkhc
 KwM5261W2h/EtOXVZe6wRYl0Rdkpz/6pGoYMzRVlP03K0ouWiXizaPpk+RYhTjmLEnnq
 k/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779995971; x=1780600771;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VUju7NYAGpeW+l4So1GiQZ2P/gBnIVrT0IrmHpAfntQ=;
 b=r7IQZ2gTS4Kn0RAt5hP2y5tiyIBYfTsJTzYn8gLZZG5p6M06P4Tn7QXD22KpZVL6Aj
 /KHkQWxxwgHzUR9wqfI3HQH++/Asc4rdouIk7hhdcNSYrUnw2Ki67XALEj3HW3EyHRZR
 W8ZFr/siFSM3XiVlK+4Q1V7b9//YrjKiB51u+6JqwFB4YPMk0+1uHV05JcDZUbNygKCk
 Gh2ftwIC73cj2zmaAcO/5vs594VryZG0L1ABcFxSVl5xmrVn+iFLiL7Hb79fcO63ZV0h
 IoACGHq2pg9Fu5UUqb1cg5auV8sgRGKjtHRJE+6Z14GJdJt+c5ofQicJym11zwF6+dcp
 COgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9k8R6CbW6+Qad3HGNcmu1IF5ykHKroW6GH2W1WalybA+BExwDF9V2CZ5BvUfKxrQMYmIn2iTFgCgr3@nongnu.org
X-Gm-Message-State: AOJu0Yy77vM+lCxHKvPbZl2bl8/OCwC3V6oPOJYvTfiL46NtN7upaXwi
 AyysEjgxUDY2vaf4nIT/gwMa0nCXeuxFuEoN4UoqYgVA+9Ch8KSG3adV+I+LO6VRZwB8bmvXrUl
 D23g+QIgS/QE51oyC35aHp7VSaemFqvyc9J6abMoUclZ+SbJQxancd5FF0Q==
X-Gm-Gg: Acq92OGt3O57ac0u4e7fFgBdalGR7zg1LDgZT4jPvzxMHyhU/Ujy6OZR1q6o0/hS0fa
 9fv+yRBY6BLrzQbfvlgvYbqnnDZ/HmqirJv3qEmPuXHnegAoxxWVnoE7j3bzPHTsgEEiV2fEjwG
 4bdsNTsx2xI2q4duUl/cNBAgTtFMPoqrWptDUf3fnIdeOyMLXpz6HHHnlv3vnX+UniMLInfulCC
 9LnvJbtP5wmQpUtbjGb+1xwjBPckxOWpRJB3ZlUGq225IYUvUmTdjYe/B54WMKNoeUEA3AQp0R+
 AvgEzptb0INBAqbggNzTV3VUVe9KvhAIa03OYe0ZA0P0ACYGdBk8ohSw/wWYTe8hM+z+FZ2HObf
 13Hc7PdQsV6BS/vKt8t40ofl62kJ8g/JhX21+6/vrzjovAuhlon/FjmYh8yor0BPR6+BdoXWQqc
 dlh597n5lbER26oMeyXc5MM02q
X-Received: by 2002:a05:7022:629e:b0:12d:de3e:86b9 with SMTP id
 a92af1059eb24-137a8e37356mr124799c88.41.1779995970889; 
 Thu, 28 May 2026 12:19:30 -0700 (PDT)
X-Received: by 2002:a05:7022:629e:b0:12d:de3e:86b9 with SMTP id
 a92af1059eb24-137a8e37356mr124779c88.41.1779995970329; 
 Thu, 28 May 2026 12:19:30 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137a948b649sm175236c88.2.2026.05.28.12.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 12:19:29 -0700 (PDT)
Message-ID: <ee897213-c4c2-4e8f-a849-294859f2d348@oss.qualcomm.com>
Date: Thu, 28 May 2026 12:19:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/12] target/riscv: Assert PTE.N/PBMT bits are not
 expected on RV32
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, Weiwei Li <liwei1518@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-4-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260527201348.29511-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HGlp4Xw1aAx1jOqDaA2UOayp03nMsgYR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDE5NCBTYWx0ZWRfX/R3bEvNyOh9v
 dP6EuAuEaK2gtNBLH9Z2B2BAfns7LEpqNb2L9kWljbQh/HsQa7o1HHrW2WKCOzqGEUyQEqnYwIi
 qab3kd+ycW5jgdf7ilVMFwMSLS5fxX+FxFj+9bezp0RIhjbqXKA2hQGZrvdIyx9LniE9rTTQqFD
 1avS4GVndRDf9X7TUTcKqVEHz+wKRppZGWeP19X0Ef9Kd5j7+ZqjxVuS1/qMkhBuifsqei+/snn
 EUbS8327jU45AbXzhGA/dw6P94Df2XGfAURu+w/ZVhd8b9HbpnjacvwXHoCIdh+pDNAI7JsQ8XK
 6CYsQFGN5k/RsTmvEm16Zfp6IoH79Qejwf3C62nLw8ngpFxahYTVEMPPyWAqkJ+2qUxhdQ9dKec
 W7T9w1mp26hpqx8cQhnAUVjF7S7SLGJ0gyoeG0VqoKZ45UZm0uysUgjnO1L7X6V3ByD9KKQuwdH
 Q0qNL58oR6vdFy5coLw==
X-Proofpoint-ORIG-GUID: HGlp4Xw1aAx1jOqDaA2UOayp03nMsgYR
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a189543 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=0mYzyVw72CmaQtKscwIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280194
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

On 5/27/2026 1:13 PM, Philippe Mathieu-Daudé wrote:
> PTE_N and PTE_PBMT are undefined on RV64, assert we are not
> under RV32.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  target/riscv/cpu_helper.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

