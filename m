Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA34CD6E79
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWdHY-00063v-Jh; Mon, 08 Jun 2026 12:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWdHP-0005zQ-L2
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:56:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wWdHN-0000ZC-L1
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 12:56:51 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 658FFRAV3596130
 for <qemu-devel@nongnu.org>; Mon, 8 Jun 2026 16:56:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QSUGk3TJYf+ooCSML7cZKYrdUwveLJi0MYCB2Z9p4uw=; b=julnMiFnJebcfuUw
 jhq4YUuzzV3SnKmnCfsJPZ6vRIL/27BaemwWcrdS39kv1fZTin6XGsPeulm+llT1
 Ke7HUFqyUkFCDErrt9jDyhnCh/NBewG3V/x+7PHPf3DgFHWFH9wFqupxBQK5Use4
 nO5VXl7AIm6uvpEJUKuvUSJTti2MTJ+J9BfYKvAipOrhP1cV1C88+NunTaW71fUk
 M17gEDQi5DrsGvERSP+S9wjDxlBeaQP/uVkRcqQgL9qsrUyfwH1Z3GdEalGx81jv
 I1Tsh0niWGb9Y4H2fOhV0p6OvYY7DAI5vda+rke3QVfgFTGg7J7170zphafkrzuc
 cIh4Pw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4envaj9phm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 16:56:47 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304dd917645so4395599eec.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780937807; x=1781542607; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QSUGk3TJYf+ooCSML7cZKYrdUwveLJi0MYCB2Z9p4uw=;
 b=E0K4TPwQSMPWUMiQZqAesqd6QKnVOrP7bGecJYd3uBU0aqkJ97y55ErtmrOOkP2ZA8
 8eIRq7PoQ5QuyWy6B6xbvdk/nKiH/SsnaNTTBHrLPb3p5/Ltj0uYfGCKbzYLc8hxy8PY
 G4CAoxX6GY7m3uaC82+fsbHKnENuwV87O3VH5sAAJ96OE3VVxIgTkc23aJM2Tv4UwQLW
 7prDli5FEJrBUok65eqw76hNkYqffxtTFreACsr0kPsLSbkOk8dxXctcW9piU+D6RUYf
 I4Q8hy20bEgcD9Jw/mPcjyAtoOCDbI1fA2NeG2ni9kzi+UJGItsmnEOZoKujq1cuD5F/
 UvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780937807; x=1781542607;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QSUGk3TJYf+ooCSML7cZKYrdUwveLJi0MYCB2Z9p4uw=;
 b=LHvCxq56YJAX7KQ4YD6Vz7ANAxuTbR5MbPv1V9BgJa1zl4PpBe39umPrqA4KP/8svv
 gTi7Udrz2r2DOMYIiV2PLLeTdpxjcalcbMxaiBfW0ArEKpraJ5+yV36y+ciJUybchf6Q
 zRtZfzrSpbHpZ2HGhffBgnA4FtAxsrIPmxNpo5y2RRZN2B8EK8FrwzIhnA9iQgJt8Wbd
 r7Moi9f6B9nxUJ777eRJx0D09H2XHeXIzJoJ4ofLEztyJkDhdqC50xbX3pDNzw6n3xlF
 49wxn44pWelkqPg3bGRkPQiohVAjIQOOd7JovakhhMbVVIhqWY8t3bsV96syj9VWVtyk
 6KFw==
X-Gm-Message-State: AOJu0YyO9Q8ad1sLaiCFjQjBUrzquWkMgH0gxtS7OMNB/97Em2oiVpkq
 oaKFV31Pnk6JeMACAIuoo3DjN5O3SWjDKJPbiG8sRhr+orpBdNfTGfUuR6maj/2xtTVQL/o8ikp
 dAlFSSFGXuc7+WKKM5O5UxGx13kfRwv+tRJStoJNXY+tPGNraPVcnhGyaNQ==
X-Gm-Gg: Acq92OEJJWU5FysC8+6DAz/xC47DiLs4+RjaxYfWxrabpw3OcgCDsfTjTtQk9aZyFV+
 x/2BnbWwx6dy/PL6P4pufma7npDMPyWk3I/gKsndcu1x27YhMBCofxxZGWC8SQ2x1SrxI67rUoa
 YP5rFQJ9tLS/MmoYAdauLuILDI0CyalW7Sw1cUh1HekE52cZ3hZGcp+DV+Fu2BDY0eAzfzPVk3K
 NPc/uzWsuihWLmuInYltSMaHajj574i2HdsHsnmVtr216JHmvg352F0D7lo5rjEq1+RDy0WTcml
 KCtpG4L1WE8eGl5SsmNoHy+Gu3WCWoDBuSRWSXJ8dakmOKjcEgUu03jVhaZjPrR9EMCER2Mxk6/
 54JKz21AanLwx690f1nqqdKRTaQOZmKdNFUTrTdyeNXWQ2oMRcrJyqrLiCdQFRUjewB4Y0/UlvO
 +NAPUxX+wvTumhkvnFxDflHlnt
X-Received: by 2002:a05:7301:5f12:b0:304:2e00:5fb5 with SMTP id
 5a478bee46e88-3077af0e98dmr8834084eec.3.1780937807244; 
 Mon, 08 Jun 2026 09:56:47 -0700 (PDT)
X-Received: by 2002:a05:7301:5f12:b0:304:2e00:5fb5 with SMTP id
 5a478bee46e88-3077af0e98dmr8834059eec.3.1780937806703; 
 Mon, 08 Jun 2026 09:56:46 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df48671sm18088771eec.24.2026.06.08.09.56.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 09:56:46 -0700 (PDT)
Message-ID: <78c8c5cf-c68b-43e4-87e5-254294fc9650@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 09:56:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/25] scripts/checkpatch: ignore spaces required around
 some operators in C++
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Chao Liu <chao.liu.zevorn@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20260603205152.1440291-1-pierrick.bouvier@oss.qualcomm.com>
 <20260603205152.1440291-24-pierrick.bouvier@oss.qualcomm.com>
 <CAFEAcA8Wx4-=MwOiwTK5=nwVmri3a54TZcD6er9XLDXhaCA6FA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA8Wx4-=MwOiwTK5=nwVmri3a54TZcD6er9XLDXhaCA6FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: OCYcrPBGMFLA5LT0L2utioH29-zUJVkN
X-Authority-Analysis: v=2.4 cv=eo3vCIpX c=1 sm=1 tr=0 ts=6a26f44f cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=BIi7VohtJD8elK1sZdQA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: OCYcrPBGMFLA5LT0L2utioH29-zUJVkN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE2MSBTYWx0ZWRfX6CtGDgM+aibl
 a5oAuT4hdd8lUD2l/yKos4Od6ubGVszN2zpfO1ygtnsYQL5Zx4izvddZq3dID/o8OIKGBVYvduS
 4ifrj8ipfWaJadusOddL9np1rCyyVE+bSV3IUrwX7snhg6tAK8ks0Sn2dMroK/H2sgiCJqbXfbV
 mrARF84HVuhhLkplHWXKP+bwwpRFI7KpTTgAUeoyaz59ksvzFII6GB7XoF4vWGzrJLQEN5qZSga
 97ZdJlBelcXxFgepSTKpf4Htmn11MLtWMdqA3vZgdl79yWtxAGQwA8s5IJJaBMwDun3X9hZVvxL
 gKxpoU+ITjN57j9bYj/vX9tWUKiUO4Vj6BQN/gMS3QWmILpVgdahSnnHD0mCMQZ8Du41Xg1IXO+
 kczb7JUExcq8jw2mZhSh8h2GhmmfmlFXRZxDqLV8EI3sF842KUN7odAjJx1rvArSvvwxPk1c23z
 bkpGL7MDG3BAiQlCLJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080161
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

On 6/8/2026 2:21 AM, Peter Maydell wrote:
> On Wed, 3 Jun 2026 at 21:55, Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> C++ has a different style when it comes to space around references,
>> dereferences, so don't report it.
>> Also, closing templates with >> gets wrongly confused with >> operator,
>> so just relax this check.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  scripts/checkpatch.pl | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>> index 2189db19f54..c74ec070c53 100755
>> --- a/scripts/checkpatch.pl
>> +++ b/scripts/checkpatch.pl
>> @@ -2621,6 +2621,23 @@ sub process {
>>                                                 if ($op eq '::') {
>>                                                         $ok = 1;
>>                                                 }
>> +
>> +                                               # Ignore * in C++
>> +                                               if ($op eq '*') {
>> +                                                       $ok = 1;
>> +                                               }
>> +
>> +                                               # Ignore & in C++
> 
> I think it would be helpful if these comments said why we're ignoring
> the operators, the way we do for the one about ">>". Why we should
> ignore "::" is clear (it's an operator that exists in C++ and not C),
> but * and & are both present in C, so we should say why C++ is special.
>

I'll add it thanks.

For reference, that's (some of) the errors I ran into that motivated
this change:

ERROR: spaces required around that '&' (ctx:WxV)
#58: FILE: contrib/plugins/cpp.cpp:392:
+                auto &[counter, p] = *static_cast<TbData*>(udata);
                      ^

ERROR: spaces required around that '*' (ctx:VxO)
#58: FILE: contrib/plugins/cpp.cpp:392:
+                auto &[counter, p] = *static_cast<TbData*>(udata);
                                                         ^

ERROR: spaces required around that '>>' (ctx:VxW)
#67: FILE: contrib/plugins/cpp.cpp:401:
+        std::vector<std::pair<Vaddr, uint64_t>> v;
                                              ^

>> +                                               if ($op eq '&') {
>> +                                                       $ok = 1;
>> +                                               }
>> +
>> +                                               # Ignore >> in C++
>> +                                               # checkpatch is confused by
>> +                                               # >> closing templates
>> +                                               if ($op eq '>>') {
>> +                                                       $ok = 1;
>> +                                               }
>>                                         }
> 
> thanks
> -- PMM


