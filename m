Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A71606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PYif2NlX;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hMxCI43Z
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xK0hC-0005S0-Kn; Thu, 22 Oct 2026 17:51:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0hA-0005RI-B2
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xK0h8-0007Ps-Qx
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 17:51:32 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MLa8kX828637
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tgof4xeQxDUPHvATTXpvhIEikVuTeNgO2i8Ax4Ed4BY=; b=PYif2NlX7XoDc+6E
 NNcnxysH0svNwW+EMqVhpFIWFNki/foOfl9F5+kEACAFHjGV7rNuMWHe9echd/2i
 GC25DAE6HiveFbBgU91BlmAJumgyTZ5bDj4dzVVYMgDtp2xF4+YDZjKYTm6kmD2d
 C2/rFikls2kJQtIoR0BQr4YZ8/4KC2afH9JTeQrZyiVn+aACaAQZ7GA7B5yQbyk+
 wOwtVZhl1UZzG6Db0NrjCRd5ivYyvpChxA/TROrmvDYNrGqknT+TML9EwWiEJAJx
 uXw5BTVncXkV5bj2Ab0EgsXF9WVLT3as/bXrqCpjRNdZfzMDayB3zCcYBYftuG2o
 t1yGzA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw17gq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 21:51:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3548cdfd2fbso369015eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 14:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792705887; x=1793310687; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tgof4xeQxDUPHvATTXpvhIEikVuTeNgO2i8Ax4Ed4BY=;
 b=hMxCI43Zsf7USNWoW9ZYKXOhKLmy5X+YcNiawNVROEsfMcPQnspX/lCWOl9gA6421G
 GhGelOPuKqqWy9lyqZWPZbMPmx8HYiSqJykhv9tuMu3WIkI42a7aRWf9NRI7jZMlH+PK
 /u81RHTqQI/F5Puhtzavj6EK7yujPgYn1s7jWo+SJcVMlVNZgIyRPhfXTQkRSPsa0BnW
 Lc1tb8Z8Qe77lxc75znM0VRnGyPEiWPoNHkKk1CR2o046I68Z6fPT2Wxa7FmJmN5h1qB
 RVrzNtz13yey2YjtOyUg+xzta0Bf6PhxydxFYD8kYJRhk8sZ3RHXJBUVBTlBT04dObuC
 7bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792705887; x=1793310687;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tgof4xeQxDUPHvATTXpvhIEikVuTeNgO2i8Ax4Ed4BY=;
 b=x8qeUIIDzcuRUkVi4ZbSSaKVe7Ta1sA9o/ujeHdZtZqgVbwU1PK+QNmzy8YiF+JUON
 vIUkb8GNR7vW8N86V6T3MzW0LnT0+X44wdTGBUCkeGtDNa5B0605K6vY6bhKWplfoWhf
 kGEWFs21nN81qaOPHn+cBuVWKKwjzNY+n5XvryUvVaM8SLR0kmDuhez8qP2cbmmLszET
 7U7Uj4JR6LUTP7leAzVKVBZRIicarcXVHwdYgzFYAV57WY9FZYa+eHVTQpPqv0utoF2/
 ho7/PyRW83pfHXS5Na8Ac0RLIc0xG8c30rjuOGiRs3XqyvAVS2SjuQc7EbvB+UxU6reG
 bSJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwR+CUbbGH6Szs4oKKbkjEBSXIiVasKbnYTIzJqFmlPyafPagpZvmO/mHQSweFmZLIl8Hua12b9dyWP@nongnu.org
X-Gm-Message-State: AFq9FYLK/DpYW6u5wM1FKcv2gROS19xb4UxQgEatEa7Hm6i5YpzNnRO0
 2TMTwTtmrugFNXK+XFJPmACq0QtvZ13cdfmV56WjS5o/u3Ywk3TaYNf7eQayhLEo4G+Qdfmu2gc
 d2sdw9oQ6ccZKjz9D6oeeGh7mUzALdc1a465tT0ubA/XhfQCtzkMB+ZmbOQ==
X-Gm-Gg: AYBFou1wMxT+FIPGgH/IZ2Y9LmAa5odP9rBfMxA1fpPhOOn2cW6YS5t2wrmp9tHZjoh
 IsXllREQ6cl4YJULfgy4fb8k/6OSSyqxVkoezzKVORUWHLLolxfT6Lmbp4ZiVx62pwas1OI0vG/
 vSX6Oyw9UfYxhI6FI5USnQ4hsrlDYOtYhbwodO5a01Jd54PCe/u4xoc1Hss4P3oEvGo4TcaNMZk
 2OSfH027/6KnqhG7x5ElndoISMHNnkYXDvUXeNWOz0wReKpwKs/ui4IyIqzLyt4WJjAe8hE8Y9C
 2F/9Oo+E9zJFw9cuI1hNXFfYEEd9NItcVle2J0AeeBoDHpFxvestC6c39Tiisn67fpJLjIeup1s
 P3s3UqmLge87cSS3CKi3Udqekp2gE2QL7MTHh647AsqGEgUbXQFlh4DcqeV6PEVrz7th4vg==
X-Received: by 2002:a05:7301:1a16:b0:358:36e5:b81c with SMTP id
 5a478bee46e88-369d97e9d05mr485069eec.31.1792705887408; 
 Thu, 22 Oct 2026 14:51:27 -0700 (PDT)
X-Received: by 2002:a05:7301:1a16:b0:358:36e5:b81c with SMTP id
 5a478bee46e88-369d97e9d05mr485036eec.31.1792705886817; 
 Thu, 22 Oct 2026 14:51:26 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d5e9e2sm651187eec.4.2026.10.22.14.51.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 14:51:26 -0700 (PDT)
Message-ID: <97d994db-940b-4687-9596-cc4ef2f30ff0@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 14:51:23 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/18] gdbstub: add gdb_register_internal_coprocessor()
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
 <20261022-query-reg-v3-4-7ad902b9a7cf@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261022-query-reg-v3-4-7ad902b9a7cf@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kW8kjjDYzXbYLqOGl8XkMT6C90xbtA9f
X-Proofpoint-ORIG-GUID: kW8kjjDYzXbYLqOGl8XkMT6C90xbtA9f
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada8560 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=pK9UF8FOw1_8_zJS-xMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfX6QT6qAx0KK/R
 lA1RPCdfHEf5u3yOt86K7Y+kLiLtwkX2HG0+WlmVyXRaexjlLCcqZncuW9ZutMRK+uIpxlATdmt
 /Uc8QpsG3y5XYlkbyGZqM4ciP2X2L0w=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4NyBTYWx0ZWRfXyJrn92xZfWLi
 wTFH2TIDBK+QlPiyAvvyvbkH2TgEPBaKKSTGQEuVbQlb/0ex173T6vawsjTur6k7Q+CiVphX7Xb
 3ZOg2vlXoV4ab4nXIaA5tI2I+GrUQ7q+3jEDjbnOBdH+bOlYplrO8E5E7nvgx/tK0/XuEC/iILT
 E+w/VnxEl58myDMujEfr9hzXDO9zgIcWETTnFdcAxH+0T2WBQcc1F611ey92/RPCYFPOwS3bl4F
 lA7i6+PNtBApb6SlT6jLzrO82hLs9Gf4OV+UnanJ4qWJEWJRPWDrJ9AOECphNGWRaoP35qDCuDG
 eC2GAwQhN1muju2C9957/s6CEzXUTXspglXLLKg1M3kvSwmQuhlxbwa4ys58gLFziZmjv1fL7cg
 TWH4yvjiSIF1eSJVwEeaSG8QfCo5z9s2OwIMVHMIdrSkCl3Holwd3KP7gMMIe400LJsg0QUB11G
 qEb+8QyHa2o+MRsBEEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220087
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/2026 3:56 AM, Marc-André Lureau wrote:
> Add support for registering coprocessor features that are only visible
> to QEMU's internal APIs (HMP monitor $register expressions, plugins) but
> hidden from GDB's target description XML.
> 
> When a feature is registered as internal:
> - It is excluded from the target.xml sent to GDB
> - Its XML is not served via qXfer:features:read
> - 'p'/'P' packets for internal register numbers return E14
> 
> This is useful for exposing system registers to the HMP monitor without
> affecting GDB's register namespace. Exposing aliases or synthetic
> registers through GDB's target description can cause problems: name
> collisions with GDB's pseudo-registers, independent register caching,
> and missing DWARF unwind rules.
> 
> Internal features must be registered after all GDB-visible features to
> keep remote register numbering consistent. This ordering is enforced
> with an assertion.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  gdbstub/gdbstub.c      | 71 ++++++++++++++++++++++++++++++++++++++++++++------
>  include/exec/gdbstub.h | 21 +++++++++++++++
>  2 files changed, 84 insertions(+), 8 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

