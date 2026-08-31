Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41908C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0wGm-0004cp-Aq; Mon, 31 Aug 2026 03:17:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0wGe-0004bz-I2
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:17:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x0wGd-0005ql-6L
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:17:20 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V52UR32679980
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AtL1WUWaVL+bayBObQ9K1N0aAEVZDfJkLtWRkFV9c/U=; b=j2iZTAuvH4k7nMvY
 BG4ksB6KRmWxOJBmh50GVaTJA9whyX/6LeyP55I3Jc1HeEdlvVPXdVMaBDpawFu8
 ROfHeBGh+91DHu9HLVpeIFWkiW/QvasSuePl/+7k1BVpj+j5C/M58laDIkmokTaN
 CNdmBH4P9MnNtLnd9UnObZYSa4jvTfI6ISGSjZ0jsa5jGiA0VaE5K7vY0PLYhi/Z
 Uiebff2k9agmNq6C1aWhhMlRCoXVffyf+w83GjET0CQ7BHEBqxFvF5E/w9fcQpcK
 HLXlsk5ng2VvIsM+Yn9nAKU8w7RHJkcV7gTOdNwc1MT2J5ZU7wPioMozNMosH1tn
 Z9jPxw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqhwd5w0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 07:17:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-9382f9430deso497415685a.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 00:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788160637; x=1788765437; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AtL1WUWaVL+bayBObQ9K1N0aAEVZDfJkLtWRkFV9c/U=;
 b=gjqfCakYrsxrk3GutQHvu830Brj2oYsVU93cm9sj9qjBG25D+I6qTNxWOlbd13OOzG
 QgivLt9U+c3XRMkDb/O+BFmiw3DeXlNzl2fjDsaCRfgzLfds8FytqCbLEChknKdaRoR3
 jOHTEz0MzWfjSVAtqxLD9hjFmbxSRT/gP5Z/jNkY89yUlruSmz+Bc20pGET9UfvpJ6D0
 1RC1Z80xpKZylgrC9Z9nEXLYySHVnwzrDKkc3I1//nd40m7XreTNFeS4kVkanw3kDur+
 oeGOOngIH+PQUzOXGVDMsDIKCVgNxMDu6tZhC0PysHKtdHQiXqDn+GbpahbngbFcKI5y
 r8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788160637; x=1788765437;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AtL1WUWaVL+bayBObQ9K1N0aAEVZDfJkLtWRkFV9c/U=;
 b=hXI1sArxHuQ4CAAr2CSe0PfLoa1CaZgEYkwCfICBaIVKM/evjSIv/tu2425SpWMIwU
 CE0Kzo8ot4yrgNGeYV7i4qKdbKZJCVkBH8nTHjlONbNimEgtlljrbuovtHVK2IRAbdNs
 5GEIBF36UMMumfc0qHwx3xZYWM52NWxGsaXhFjsXHTBMa2pgWintnh/GtJ8vzPCLK0a5
 8D6KC9Qt88qyzCMS8jhXoD2iZMV58O4GjD34+Sd6I7f/giCWV01MvRZQGTkTz7yb5GOW
 JCS+E8vRCuS/u/KaCK7ck3LLrRhEStOhz5oeU9y3MsJZaV51IRIfffpvV7mGm7ZuCv4t
 mZJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCErA4XdGPxXdvUbeV0cftiUebAqGOE0kkB8I5oOnu1PqMxGLf+2F8wGy+SWo2VdA5IC8XnZmvmIQO@nongnu.org
X-Gm-Message-State: AFuF++nabbleTCv0qx4zJnYrz9lRgdBeWxLVn7694cDj79l0rx5sWMkZ
 fV0/nNfUqzWStDAvbea3NyJ4xu99p2CFak14BB4WE6mq5jlKPa8n2sQHCKjqGYoSJlGOb7XKMDQ
 aBvRsA1DQYlSDIOAyyJ3UfmP4+Ivuyi7F5aYYR9M/+rbJPCEiVyAl2lGrLw==
X-Gm-Gg: AR+sD11xNuCZyoQARy+xnqun4AA90fAdfXbLeg8Mu+WQK2+iYkKhvEWIK2//o3lH2L0
 JgZdHpyLz2105s9ec3jOz7X3hNV9KO/rddPQlDLODqIkYLj49OkGvwyv31Y29r7UF8qPSsRAW4T
 8V/OZydxqQAKEQJASHglwFjeyZVtLUvnEKrMd9t2cxXT63eLvXTze697/s4F+ysU5m31OQfRDyo
 CJMfrYXutrefvnydXAmj/Tk3on1XnuZZqlHCN9tXDOLJFtxwrM2B28zu+DEc/eBsC9i2gFEPEFS
 8aEChrpAen47+d8UeuTHQ4E3YKB6Il+LokOQHCVhkj3skBYe3vJLrhq/slROO3sOdTHj/8xKzGI
 lrxZVkWaXHhyHDPdxMf4XUraDGdDJwhNd2Q==
X-Received: by 2002:a05:620a:941:b0:936:576e:227b with SMTP id
 af79cd13be357-93913909dfdmr2210482985a.24.1788160637126; 
 Mon, 31 Aug 2026 00:17:17 -0700 (PDT)
X-Received: by 2002:a05:620a:941:b0:936:576e:227b with SMTP id
 af79cd13be357-93913909dfdmr2210480185a.24.1788160636677; 
 Mon, 31 Aug 2026 00:17:16 -0700 (PDT)
Received: from [192.168.69.226] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9267c369sm183907125e9.3.2026.08.31.00.17.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Aug 2026 00:17:15 -0700 (PDT)
Message-ID: <d9b68dba-ee09-4348-8bbf-6c82bcb12d55@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 09:17:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 42/47] hw/microblaze: filter microblaze machines
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
 <20260828225901.367438-43-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260828225901.367438-43-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: kmwbpzJcfAVrq7xEYESxCnezIC5OFYAM
X-Proofpoint-ORIG-GUID: kmwbpzJcfAVrq7xEYESxCnezIC5OFYAM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA2MSBTYWx0ZWRfXyTmCFJvJ65Mp
 VyZKuxnRVuT390hZ8CfCivSj3eYBjby2KTdt/FTtXskwEFaP+JsFd/azmjPzzkcN91092h4euRb
 TTVOO4VeYctRdJ9mgpHWZQA+4MQG0GI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA2MSBTYWx0ZWRfXxY0BA6umewzH
 XfJcRXHPV8beVLGpffHTihMiZQgiMwCHbDdXl3xYG0C5mzKnpRLkDhuyEiiysx536uVOX2y0W8r
 4jZSlp2fbUadn6o6Po4O9tGFVuVBPGCk0Ttxw6y9tl+fyAbH6d1cyZ7jW++sRVnLg68yCNZp/sF
 zXEJr3XJhjtkXNR+JR6y/MRmCD7fDXfkCo/USdUTaKt9C8apWHLbdT6p0DenzKPKBQnjZArq+up
 I2OIV54rFqvbcw3gYl+BEB4tC1SGd23wDNuPapfetE6gijO5l1+jaI0ThIQyVx4tvOTCt4Q4zPv
 bVkb+x1Ei0kdlZ8tKO/ac1+eERY2xuwk6y7lV08JWjy4c6HmRPoO2HPXBKg8c0l0sKSXQvM2cSu
 fAzZ02hgi9Fw8PdHiqmgA035SQ2VMOpHD+n0jCSOXZWJ0UY1wR4o6e4qriEaDwrzZmX8SKC62n4
 GGpvcT1w/ntmgoZfhIQ==
X-Authority-Analysis: v=2.4 cv=YKKvDxGx c=1 sm=1 tr=0 ts=6a952a7d cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=C-MnB3pT6mmsLs8wCkoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 suspectscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310061
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 29/8/26 00:58, Pierrick Bouvier wrote:
> This ensures other base architecture than microblaze don't see these
> machines.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   hw/microblaze/petalogix_ml605_mmu.c      | 3 ++-
>   hw/microblaze/petalogix_s3adsp1800_mmu.c | 1 +
>   hw/microblaze/xlnx-zynqmp-pmu.c          | 3 ++-
>   3 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

