Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D09D7C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 09:50:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x245o-0006uD-QL; Thu, 03 Sep 2026 05:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x245n-0006tq-6y
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:50:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x245l-0005nP-Ns
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 05:50:46 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68392v4J269128
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 09:50:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HwVjxPgFU+G8RlVgpKGB/iDqz2ywiSx2v/CV7c/jNZo=; b=YElIe/WeThi9PQH9
 m3wuT0ky1OKb1KvOWq2Y4mSgF9F8luKEScybeBom1DhSxmhy1l5bMVFw9eWuQ9kc
 6k8Ar+FdsHcFsP3GHcG27KSBJSWdcyriyoy2c6g5U/sIq4VxfOMfCmhy5Gm+Ph6K
 eejW8cQ3Z8/fqNlt8PLNN+9VFXO3Cd0/YgcYtHMap7bq8SR9zgIdSZphAsb+0mFN
 Wr7H5SPqAsSiQyX9JvxZfeWgZA3zGbvbRsnW/R1joc5BV5e1iBW5y4KfJGnnoWGi
 2MlUMixvvxbtiH/52o3FFrx/OGN7+ekHmspw7Oum3z9NT6XFaAldMgzGYNuXDM8T
 F98Yng==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjhcjuh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:50:43 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-939062ecda9so318627185a.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788429043; x=1789033843; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HwVjxPgFU+G8RlVgpKGB/iDqz2ywiSx2v/CV7c/jNZo=;
 b=FlJmH9TXyd1AVAEPSTUXJpWT2oE7qZsEsHlr4xgfoXLi4aPhvl3oZfxl86d+5Vd9iu
 EYrQqg30/EH+R10QS7FayLaP7ZOULyIFvf/XIaAxNC9RtGyl6HoklX0O7erJh4mScSSB
 HJeZ5KbhcVNeSNPP9iGWKwB3kEdI+d1FCs02612EqUzj/kiG5DwmPoQjfNR/w2TZmExg
 IffIQ6Hc4GfBeg2AK+MHBEZl3gWtZeLQH8PxcyPYiQD+I9WCW0r//pOZMRYGcczq7QIV
 az6qmtnx/S4BB9E/9HZf/iOtZtF/DhR75VXnxFII4KnnFAFTP7L5RIZkYATQvDw252Ip
 rjNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788429043; x=1789033843;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HwVjxPgFU+G8RlVgpKGB/iDqz2ywiSx2v/CV7c/jNZo=;
 b=SfNB9TdNuK5FZv4IczGpeNlpnCtDXrAevyJcQet/ujQSQ5mQE7vjcCHG0VRADNeMyR
 Pmt+pjBZEs9gLrj9WN274CoEwGKWDuvV7ccLs14tcfN9DmCUQBH3wUBxLMD0n85bZhfo
 j/IywRCk5J9mijncBA6/Ay7tdROAQgvfAVZjuzESkt00djNYOLsDBPAKX7XWbcFbkOrL
 3gFqEwBYxzpXqgPCuj4UKFURg6Pkow9a3uTQucRe46xeNTzxuYbUSSnPlpmpabIS9J5O
 q5TzLg2TUHcqhD5DfEDJhYxFBRv7awqxPYyrHK1ozP5NV5Hp5s0KwRheiq35hEgLWp7t
 /kVA==
X-Gm-Message-State: AFuF++k4SVv8fLhfvwwVgbeCpW7wP0oj3FM7ltLhnxKdQLhXWEryY2gE
 5d/0yLbdEoKlIh3BWbVr0ckGu3tdstIE6mlccqBVolelBSi5lAoW8bbkFp8EfywImni8nanDqnw
 3Xni5XiEjLaO6zyv1MnDxOpDQauRfSEWjtpGybekwMR5GQP9lKF2Kz0UbTg==
X-Gm-Gg: AYBFou2ayKvjWTAIfC5Alr6UZtVWGxghmDeOFFk3PxcbToVSwh+ci3rns7xjtcXgGQv
 CQLmFLzlhetpuszSChhY/1z3Ng3QeXlbBvm7qlspSQpi9ElpnsNq6SCF8b52ODvL4VEBlQuxB6I
 ZWeSI5Jfr61LTweqLpLfxTmzr5rA4YKv6wZJ68plKYaZxOZ9nsIvj9g4WDrGQLgU9OxdG+n5xRp
 JXf6PHpzDfgZU7m0BkW0gLMcT1m2BeHD0C4DtLQlA2nePtzNPInrHBOe8zQVhbRWNXM+KUhXZ3x
 0r/DvoZ/Dw4qtwA39s1fxEzB1YrrG87Joz+eUP2NYnd/xFPMtKjQYri8yAUeDcrHPOjsGpENPCI
 soKu1PnmPXN/ZQrCoxd6F/B7UodFucv0Bqw==
X-Received: by 2002:a05:620a:f13:b0:937:2ac8:bbda with SMTP id
 af79cd13be357-93960f52da3mr1151219085a.35.1788429042911; 
 Thu, 03 Sep 2026 02:50:42 -0700 (PDT)
X-Received: by 2002:a05:620a:f13:b0:937:2ac8:bbda with SMTP id
 af79cd13be357-93960f52da3mr1151197785a.35.1788429037604; 
 Thu, 03 Sep 2026 02:50:37 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce47b9817sm102512275e9.1.2026.09.03.02.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 02:50:36 -0700 (PDT)
Message-ID: <509eba9a-9956-4be1-8bca-fe261648d58b@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 11:50:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/21] target/i386: Remove const qualifier in
 ptw_setl*()
Content-Language: en-US
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260901095229.72018-1-philmd@oss.qualcomm.com>
 <20260901095229.72018-2-philmd@oss.qualcomm.com>
 <178826135506.50872.3543134957639273965.b4-reply@b4>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <178826135506.50872.3543134957639273965.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UbwkAv_YHxKP8vaeyz1wvOpx4-XfU4zj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4NCBTYWx0ZWRfX8pbKsZxag0l9
 Ce6xq2v2XubQpacSKp63FooJCFwbIzpZ8LMSWVNiHmYT7bnRSrklNl0hoI/LMBW++EbErroNFTY
 Pdc3HomUnTc5PyXWeanT9qMimg9NaSayWXWxGpO2uITmGiWE37XxW3thXN0+yGkNmS7WLGCnN0v
 Ab9RUtzu/BcowKvc0H1k9Umw8Qp4OUR1TVO58LGtCFVEaso3N1M5koTF0zJIPMdhXBx4lUKQ7wF
 qeQAPPfwZybftTvYEMMrtX0g5Xy4bpeipB2i9WdfOHNOFTbh8AZXFf/e7likxeVND8E7NMj5S+Q
 cr0SlqaunqfkesF1rzGWPMsTmCadPduLOxtOCaIRywkELDElpNB8NAwV2WFhVeaD16QBFfOKmzB
 p/imb6d5mELnncEyrIur9EsmLvP7LWB3lP8IBfmxmIecp1TVl7Azz3GPGJYzJF55dY4ZBSnoV/x
 55ECQYDEXxNNt037wyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4NCBTYWx0ZWRfX/Ro0Dac0xdsl
 XquIzIdMnklJse/HhOcqCabDV3W395Y9wQokG0haE5Mm2CPRezJZqkmfiIA9zn2gTu+4ddeKApE
 PrioS94EBneSFtAQNzsoZrcTdRZ7ff4=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a9942f3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=tyUD48ZzS5WoX1m2FUMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: UbwkAv_YHxKP8vaeyz1wvOpx4-XfU4zj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030084
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

On 1/9/26 13:15, marcandre.lureau@redhat.com wrote:
> On 2026-09-01 11:52 +0200, Philippe Mathieu-Daudé wrote:
>> Both cpu_exec_start() and cpu_exec_end() take a non-const CPUState
>> argument, however here we get that argument via PTETranslate::env
>> so @in->env can not be const. Remove the const qualifier.
>>
>> Fixes: 4a1e9d4d11c ("target/i386: Use atomic ops for pte updates")
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 
> I think this is not really a fix, but more like a style/contract thing

Well otherwise I'm getting a build failure (discarded-qualifiers, but I
didn't record the output). I dropped that Fixes: tag, thanks!

> anyway:
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
>> ---
>>   target/i386/tcg/system/excp_helper.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)


