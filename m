Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 430DF606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 20:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YJrRhlxB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WWCba7fM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT3ft-0000o2-WC; Mon, 16 Nov 2026 15:51:38 -0500
Received: from eggs.gnu.org ([209.51.188.92])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3fs-0000n6-Gx
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:51:36 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT3fq-0000p6-RI
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 15:51:36 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGJfWPf912906
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3Jg3Bkt2/KhRR8rBbrRFEvbLXjs8pi6/2L0NGekpRrI=; b=YJrRhlxBc3rhR8cN
 Nt/xO4J9i5xx18U28IwG2aQ+LtT5NqJJeLMichvdGFDg+lRnzUfQ7px1QxikJOfW
 EUUtPHmvuTY0fq0VECbKsrVPVEtnoK0wylCBSbMLxH/H9WIpkt52e3pnGRmgrKsv
 MBEhnZqPEGk/R2752PhHG9Z+AE+xJmq7WCa1PTH7P8bMr6nr+Cw/P+IiI2inEYFv
 23bEylnA+wPk26cEZvz/cXWSZhWUSjvqqF9Jk0F+C4bZ4tG13pynSdPoOgKh/u2o
 kb1Evzy1BH8rWxI5/HLIBB6a8m/xJL3e1WjtoZodtmdRf8IEivE2BaazEVTg0OmY
 WH5LJQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j034y1pcg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 20:51:32 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-370230d93efso3873099eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 12:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794862291; x=1795467091; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3Jg3Bkt2/KhRR8rBbrRFEvbLXjs8pi6/2L0NGekpRrI=;
 b=WWCba7fMlaZLDJvOIezgDOxOJzTDH9r5AClTt2HTTS1OwdXigEtmmf56xUi30RsD7O
 zDYuYx00yKERlC3GZkfmFeAMZL1K0+QvjGqMKGp+RIW//6P5RztvbGwcMaQAE/szfOQ0
 i+3lkK2gj3Kk9izBmnCvEf/MtffCw/pSUTeVuEFDEvFZjoUWT4x6e5bPkVXq//CqsN7Q
 qEar+1rYXMJHMIcV0ycfXTGT5Xi5o1BSYTU35XbKuf3jppl8dxIKqIbthXLZ48Ssd5Uc
 a3eHvZFAxxqm7IXneSZWhJuBjNJN4npu3jzaRyDrAE/PTpG3pheOl+VXE/3CKoBX/5Uu
 JfSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794862291; x=1795467091;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3Jg3Bkt2/KhRR8rBbrRFEvbLXjs8pi6/2L0NGekpRrI=;
 b=gfScN+/yHJKL3+X0ohq/QPNEOOfwom0KPOwZA75mvbu29E+LsBNOeQbrm5Elkh8srt
 DJzS8ew/1w+Cd2IIsOn0FczUwkCvfogJFjb1JJ6D1r4uWAPZTFoiUi7nEYhra+pDPCnR
 xw5XwRft858TfMYp1vi/jHRi8YYbAZ90nmxSghKzVzowSILGIE/5ANxzPjncAxviY+yK
 /b1kd+7LKcHAuttefchZlSUvdKAFPB0atof4uKBW4nwFTYx0L4RngtNh/jGc7MOohniu
 iLXBnwBaoaAJy45S5lfWkyRZC8uIQ7NKD6yiMY1hfbwsJP0ZzGrO8C5ugZ46EVgac2hc
 XpZA==
X-Forwarded-Encrypted: i=1;
 AL+hErH2Z8Ihwfu4q8KsvFyQvAcbv48KfuBKJmg1bnY3bgKsa6jXtcSMAdD8U3EiV0mgc7QxUz+rlwRoMalm@nongnu.org
X-Gm-Message-State: APuU4Z/cdNOTacP0orHfiwq7CaWDpFSlI7ssps0DFdkjE/W4MyuA+TI6
 evZ+KQF3WKZo/LJbxpolYfxtFvXszrslRueHNgAVWATWKmw60L43TQm9xOtIiMmXo9kX/jyNErH
 VT41CgeiXcjc9yBUjSognkzgogWyu7cKdr5dLpgC/hNhPR+FAdh3dRXdW3w==
X-Gm-Gg: AYBFou2XhYDC/veiqPHdGzIXnhusylaHa8b7Ew8zFqTsRzd0xrpQYshByaE+SaIJ5KK
 b/orBZegZstZy1iF4X3x+nEfHsQeemJXI2xB4/OC/SNDED4Q0AxaZXeMAimsVyL9PQ5tQS8xYYn
 HC9+uYG9ErU9p8oGL1yxycy1olv5wHCwg6LjuIa5HYKtjtPPIGdHyPoGfTi82r6tM1OsWhm8yud
 AEVy7hydJgn7vPEVXvjUsBFdr6bFLIA1j8tAUNoG7Fi7dvlnLSuEdNpUJ27NH3GMpLxr4vlZUyn
 aDQGCU+RB/LEmPmcDww5338oX6J53nPBuAcwT7gTGaOdFhvYRqByqnhbt7AQPJ3WWHmj6xe0nCB
 vp2dfSkeRoCPzXbL0lGn2SoGzXqp7O/RmxGiD2gDezVxKDxUdYdf1ky0QwlHT/kV1hqNH5bnH0v
 hTkpWwbGUD3IOVSkgpsZFBiC9cXNleRVSf749zTDp90tU=
X-Received: by 2002:a05:7022:b0c5:b0:1a6:7a2:cfc3 with SMTP id
 a92af1059eb24-1b5030e067emr12031959c88.13.1794862290608; 
 Mon, 16 Nov 2026 12:51:30 -0800 (PST)
X-Received: by 2002:a05:7022:b0c5:b0:1a6:7a2:cfc3 with SMTP id
 a92af1059eb24-1b5030e067emr12031908c88.13.1794862289456; 
 Mon, 16 Nov 2026 12:51:29 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5031b98e5sm37881782c88.14.2026.11.16.12.51.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 12:51:28 -0800 (PST)
Message-ID: <158ba1ac-d119-4630-b2b1-e0f3e9df2285@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 12:51:27 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/48] qom: define an Aliased interface
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-5-berrange@redhat.com>
 <a6cf98a7-5a3c-459d-a811-a5f215056aaf@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <a6cf98a7-5a3c-459d-a811-a5f215056aaf@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: PYQNwAmjuuJukVHr4Vawd-E6Wq3mVWXy
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6afb6cd4 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=20KFwNOVAAAA:8 a=vAO0XGklu0ZB1P930XkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: PYQNwAmjuuJukVHr4Vawd-E6Wq3mVWXy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfX5o5FAQZNeShY
 u7DcHnpDjBLeWikEM3eJWdY6NyFQ1te6ZQ03FYBjEH5368YjPO3FDGiD1wc70LoN8Qe9O89LDCe
 H9Bc/m67txBxNj9n+2D3eaAOkPn7NvU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4MiBTYWx0ZWRfX9CpZhVJXPozF
 Y5JEhHuMX8ycl+zuL51qmuJJaIIyuzy2k0511wNuQcgnIXyml0WzhFJ3oRqJiXFUIt7c6eTXzXx
 XgpPkm+JnYiaPW1FtbH1DZn/NInt8sGBmXRmtUfrWKU7/HEQn0kY3gRSmgWdxFQwPqJ/VaQXgDU
 FvWBT8MUCqternr6mhNu81g4N6NJjDhMlNoSJhOHpqFZaSxHuGr9iAwIDhZkvXcTRmXweVMYUs/
 3COs5KTPA1wwd4MmEx0grjH8PBTPV8za8w8ZP+hAdMWYKu6BdcfbS6n6bB+0hljzu+THjfBwZk+
 iG2pjKi+bq0RZCs2RcHfkpMH+J+GlTjZ2fdGwYIbEKyxXd5xTGsKMnejl9TfATFheVE+lgewibb
 JXTqX3MRJ8BAFsprgnYeDrhTJOWeDE3jfKgjg4jHVFseC7g7BQkDE3nTLKdE8IlVvAiWl4Al51N
 T697Er5W0H+GSR2jLKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611160082
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/2026 12:41 PM, Pierrick Bouvier wrote:
> On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
>> All QOM types must have a globally unique typename, however, for
>> user convenience, some might also want to have aliases which are
>> permitted to be ambiguous. Define an "Aliased" interface which
>> can be implemented by types which want to support aliases.
>>
>> When resolving an alias, if there are multiple QOM types with a
>> matching alias this is considered an error. Ambiguity can be
>> resolved by matching system state, with the selected target
>> being the currently implemented filter.
>>
>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>> ---
>>  include/qom/object_interfaces.h | 77 +++++++++++++++++++++++++++++++++
>>  qom/object_interfaces.c         | 57 ++++++++++++++++++++++++
>>  2 files changed, 134 insertions(+)
>>
> 
> Looks good to me.
> 
> Two open questions:
> - Is that worth supporting more than one alias? When would we need that?

Seems like at least arm/virt need it due to explicit versioning.

> - Yonggang mentioned the possibility to couple this with target, I'm not
> sure we should go in this direction. What do you think about it?
> 
> Regards,
> Pierrick


