Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B32F6C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:54:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9zy-0002h9-Ae; Tue, 07 Jul 2026 13:54:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh9zw-0002gw-Sr
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:54:20 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh9zu-0002T3-JB
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:54:20 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTiZH3996641
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 17:54:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vioaBLFFk6nOSBERdp4i5CubfF9o1TbSkQhYslq3ATI=; b=BVdgVrbwMYUwUt9b
 PV23761uLG3ghx8SGW4Yzh5ou3PFSCmFbUptdaqKg4EJGShmJgb/93yIXpTGxU7q
 nBTzAtrfTuTFVR3CSxM72pp09J4ep6QciGW5gbgOUr5spi6EEgzEn3BDOiD7XkM/
 cNRS8hQweP9Nfvb6416mHS9mu0YUD+qw7rKa63HCz8M+5pFRTTxul3kqtbm+psdl
 uY66FjwAEYLGg99n3jU3gvRhLbs2WkoW1MiMpRTjVRqsGLXZh0v+P/5J7uvY1dmF
 9BlSjI1vJEfdnDes/Y8YV7ZsJMW5L4C7ONWsVYBtVMMfbIvidNJ8A/1Wi8QzsBgL
 Gh2IQw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su73d51-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 17:54:17 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8924f4d0a4so6481292a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 10:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783446856; x=1784051656; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vioaBLFFk6nOSBERdp4i5CubfF9o1TbSkQhYslq3ATI=;
 b=UVWMQ7dT9xNXPCvIrkn6BtDkVLV3pieK62SRjVbDcmSq4X+F5v9m6MWP8ZEdvnHm7W
 XWlD1TVC/7jvlrQQuGywBtHkDyL7PiGNh1YbSbFEUI5JtIYaO4k0V1onBfuLP/K9QlPG
 EMN/pBIVOw61rx8Z1kNXIVZDEsq7wOjffpyqE0n0YyToppzFP51mtWYvv1boAwk+Ph7u
 ni8MswNurDYPx/oj0OsiM5ny4Z7DOhkdmt2tMHdDQ8RetgSJ4SghUKVURQLuzH+KoqlD
 3izxrJBwUT+n2Z3BYMdjZmPlFDrJhUTG73NgzY30wOkeI3J5lj9QBN51xhCALsl5eJyq
 xuEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783446856; x=1784051656;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vioaBLFFk6nOSBERdp4i5CubfF9o1TbSkQhYslq3ATI=;
 b=MEN7C7RBPvvUe7C3FWcq+Z43NyIIF2dYS73eZmGpVHwO8TOROk45HFpsrasO6jTB0m
 8SIYumImsA/WhCAafHo6CGiZkwu7qYLeIKNtVp1F0oCbZ0TV3fWnvNGZibAL0lc4d1cx
 som9oBk1/D2qrPpaFV+0ecBRl2XJQ3gMfqUSf0yTxiQYWa1tyzIaZL1W5YC1NT1f5dyC
 7OURsnA5qR93L1H7mTx+3oDVLD+u8rT/qAPih/plL2/A8gzT027pDQwKI67EomMTQrQ+
 HiUVhS5df10/gOWTorv/ObnkuMmKgy9n26UQgDFq+oMx7KMNFEb3pLII2n0mRv5Z87i7
 gOQQ==
X-Gm-Message-State: AOJu0Yxx+9nXCWoZdEUBSTncM0AKT1z9oss184C6jSASWz+enszOd2Sn
 C+Js7wnsHR9hEuPPJmT+MVWMf/jqOpqLn64tWICI9TstmgpVteEOD1x+zZ6DGMJsigGKque0aG2
 LClOi5bNC4eRHxL+LG1ScZ4KwmQPq2jqo+dzJxGZ90jjgoLsPSpk1rsE6xw==
X-Gm-Gg: AfdE7cnHuwc6NeuvrVis+BWUWRqakRYFru4r3t83PXw9cPGbD6/m2kA+88GEoqRAeMH
 8S89HTL5hYCUo191xAg4mK1HJA4ooyWC27H2DPsqTnqUU91OqWXNCR61MA3zZNQIwOIhzFoyIH+
 tFlBBN0DOd0WnOUDzQ/gwnaTIFfxVwbhS1ZyK9il8qNgNcA+9py9SXsx/HzeGKjdom2GRe7jDpJ
 d5i08hc8tTQq0EdTmOQZNq45eW1BTjoW+l3YSqpBgtxskTYZnsfU9sZopnQUJwQpUcUF2bFqJTI
 8vpgoYq5NVtYLBe64cfVQdlLLqodPIJjkwtEqsZWSD7sPuMXZuLOomjPMkxpWUF4Yrmj+1aCL6c
 qPm/EZrVa+Ml+TTBvYtHWFJO6Y560xXijghbZjZu5lL+YV1bnX00fkOV6jwzREVXIXr7gxNDDUw
 ZeCvY=
X-Received: by 2002:a05:6a20:748d:b0:3bf:6c08:fb99 with SMTP id
 adf61e73a8af0-3c08ef84f89mr7264462637.59.1783446856479; 
 Tue, 07 Jul 2026 10:54:16 -0700 (PDT)
X-Received: by 2002:a05:6a20:748d:b0:3bf:6c08:fb99 with SMTP id
 adf61e73a8af0-3c08ef84f89mr7264429637.59.1783446856008; 
 Tue, 07 Jul 2026 10:54:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311748394acsm10905795eec.8.2026.07.07.10.54.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 10:54:15 -0700 (PDT)
Message-ID: <f47256b6-c49f-415d-b3bd-da8487254797@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 10:54:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] accel/tcg: Make PageFlagsNodes' start and last
 immutable
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20260706165445.57418-1-iii@linux.ibm.com>
 <20260706165445.57418-2-iii@linux.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260706165445.57418-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE3NiBTYWx0ZWRfX8yY5pULF9J+c
 CzZL1Awj4hFEgRdImIgUnnSWu7PjmiqR7WsRwEjbSEeFGGG5npkNPv2hJ5h3Orc3B3hEkaxkO3r
 53bDuccegI00ov+YPS1ZgcfLnlBDKJa5CA+HfKpVTGtiL67KW3uT/20marVRGsCNjY/NMQgd0rj
 OIPulVrNTwmTEJNG08OCwgIcj6q6rzzfaEa7D2bMd5lPJM1NSFLD2VCZjS1pVndpjt53Svths5T
 +xpy/jjYJa14dA2V4JjJhsUMSm4S84rlHaLJu9EV1acwesBYDQwNGeF0VtY6rWLxxyInFekak5P
 6q5Y0UBptGTxZUy23fKqtjrh4f/8culclqYspIr3Zw0JcoWdnxmb7AX652uojQ5ysGhqZ88s68G
 eoZVF7tmT4Twqj9K7M5HoTgS+w8X/vytGnSonQ+v19RZQ8mearF+JNGc6Ib8rMZxhXByGR5u1JP
 4vuQjCYB6neINPnSbqg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE3NiBTYWx0ZWRfX00QAfg3j+q4E
 jsGAaVVlIfRAWwaLAUWo/uPxOhCUAjDrS54+Djubf3pVNn06RqOi4cUYpgGOnaCgqcyrPwtfQ9E
 gW9GQ3ExGGiYoaK/Y8P7RpK00RsE0f4=
X-Proofpoint-GUID: 99Zh4_oh1NCfdJUlunSQu0sZIMGkHpAK
X-Proofpoint-ORIG-GUID: 99Zh4_oh1NCfdJUlunSQu0sZIMGkHpAK
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4d3d49 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=NEAV23lmAAAA:8 a=VnNF1IyMAAAA:8 a=EUspDBNiAAAA:8 a=6fmV4ESNYXtuklM40agA:9
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070176
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

On 7/6/2026 9:51 AM, Ilya Leoshkevich wrote:
> page_check_range() may race with pageflags_set_clear() as follows:
> 
>     T1                                     T2
>     -------------------------------------  --------------------------------
>                                            p = pageflags_find(start, last);
>     interval_tree_remove(&p->itree, ...);
>     p->itree.start = last + 1;
>                                            if (start < p->itree.start) {
>                                                ret = false;
>     interval_tree_insert(&p->itree, ...);
> 
> leading to errors like
> 
>     fail indirect write 0x72f0a659aff0 (Bad address)
> 
> in vma-pthread test. I am able to reliably reproduce this on a machine
> with 32 SMT threads as follows in about 25 seconds:
> 
>     jobs=32; \
>     seq "$jobs" | \
>         time -p parallel \
>             --jobs="$jobs" \
>             --halt=now,done=1 \
>             --ungroup \
>             '
>                 _={};
>                 while ./qemu-s390x tests/tcg/s390x-linux-user/vma-pthread; do
>                     printf .;
>                 done
>             '
> 
> Also wasmtime project reported a similar failure pattern in their CI [1]
> with a similar reproducer [2].
> 
> There are other races like this. In general, region bounds mutating
> underneath the reader are very hard to reason about. So fix this by
> preventing mutations and creating copies instead. Use RCU guards in
> readers to avoid uses-after-frees.
> 
> Now, when the reader finds a node, it may fearlessly access its fields
> and be certain that at some point in time the respective region had the
> respective bounds and permissions. The downside is slightly more
> expensive mprotect(), but complexity reduction is worth it.
> 
> Lockless field accesses should probably be wrapped in qatomic_read(),
> but this is a pre-existing issue, so do not change it here.
> 
> [1] https://github.com/bytecodealliance/wasmtime/issues/10000
> [2] https://gist.github.com/alexcrichton/f14f23a892ffb9df2522754572d51b1c
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>  accel/tcg/user-exec.c | 37 +++++++++++++++++++++----------------
>  1 file changed, 21 insertions(+), 16 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

