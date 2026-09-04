Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511E3C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 22:24:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2cJS-0002xU-8s; Fri, 04 Sep 2026 18:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2cJQ-0002x5-JS
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 18:23:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x2cJO-00009j-CV
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 18:23:08 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 684KbSeA1568687
 for <qemu-devel@nongnu.org>; Fri, 4 Sep 2026 22:23:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BretlBW4jlLRVrhRnmJ1EmWkSn8JgDHnIz9p+Zm70oE=; b=KJw3DHP9l9rr6fTd
 tzCNI3iU3ZBcLXHBueGz93Zy0JEtyUs4VI9I4/cGfKk65JTTzKlOfwekbUwh+TST
 BkNXMTVbjGF7h9Q8yPOfFmqN5SYkKkaYdzJ00ZCXCN6Az9cpcg3Cn1hSR9+cKobu
 +rRsHWa1TuZTSwsjCNVUddfEcfdh9gSJOB/hMpH2lM9jrDNkdwBAQ90G48dZNVTR
 lIJUNIYwofIOAUVLUwlxVldXslCVVZkqOjUzVZcP4fqaqN+wAy41Y/Dg2YJIJgDX
 X+jfCqA2EZeahSVaxd4e9BwmoY3aWlhu9MsVFmqpOiP3k+Vpdq+6qLQtgb62bXSi
 aPi2Eg==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gg00yswgm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 22:23:03 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7f582244e9eso28769687b3.3
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 15:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788560582; x=1789165382; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BretlBW4jlLRVrhRnmJ1EmWkSn8JgDHnIz9p+Zm70oE=;
 b=i4hFCN2MNC0qIUY57zk4m+mhV45Vy9svfMP2Vgu69VKBMTuBwl+Lf0LS0FDXMTrq4z
 GSODNLEgPU1xs278UC0ctgIVSuC7d9J4xaKcbUz4WrhAMI8u81++wZ4F9xPIOLjT1Laf
 3Xx3RlAIDNsEv26vQQunmOPhO1a4pNeq9XSsEEi/VHnWHpw4i4QgU58RnWnBd0LwOy71
 SslysSZ5v449lJ/BeMrtYE+Uo3Fr+bMPGWVbT6KDlekVe1diNjv/gfujftofXzeb821Q
 oyIrlvNE13eb+vavsoIIRshH6N3bQP87RiPU/uJMx7ONbD1nqwp3G/Jlaf2RBBOIPTho
 SpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788560582; x=1789165382;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BretlBW4jlLRVrhRnmJ1EmWkSn8JgDHnIz9p+Zm70oE=;
 b=H9f7lxekPzqu6ZkdTYdwAfNffn6kBHzS+SR+UizmnW6XtHY+0+umKFuN3FJoOAbQPu
 2CrZ8+no/pvcHEN/Vp9Q1gGq32U/MRNLD2CybRTl/3xabyjeiJiByUnIqcVKKWkTtNWW
 v04Z1HYZTUfPrhdFJaf/xzZn0CmoYWpWhJytRS6F2Z/teKJIbK+b6CTlWSlOImgnL1S1
 Gy3fnG8hpXtgO0EhKrIvQieAUgCvwptCPQOn/7ikj8nqtRGbiTWIm90m+dy0/BydvTRD
 Dr2wVJ7eeyVYnUteQUW7EHMv1C75qPO+byosKfeWRdcu7IbsdJBuiVViZQkyl4XEa0CM
 NJIw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw7y1VNePxlza4Cg42OwLP7eaEXID0ROR4OBA/8Yh+O4oteW8wiEQZTOW3hfCPsFBXSpbpJy1RjwAqw@nongnu.org
X-Gm-Message-State: AFuF++nya4FGQ5iPr5Vuc9lKPoW5zoFWxq9tI9hA02oNYhKi+5RynVhu
 6V4CwyDriddM6nBN5uJ58zWiDVH0RGnEJubtTX4YaYqXrcugB6pwDklCrwwIZAcEHKwNy1X8t2Q
 OKHMWBjcmSVMHLBCiwRebCNM6WDrthi/SJrYOeRcd/4bTjdsyMnbGRiuEyA==
X-Gm-Gg: AYBFou3y/XuYWiUApiXiOeFT2FC5aFhR60lIklMa7JfOsfO8PtcFDMOVBsxLY26gzjn
 11NqK5SMYkYdP0mujDkJuQID7q1reNBSyh7qP3EAK5wlEWrsw2ysKkKQ81CNmz9pyVOb4unZKiN
 kQtUR0a4kIRY6MlDRlUiUmALfVp9gD1/NX+Jxp5Mkoq9Od6xuga3MPbjSeCuY0TItG517yZNyIF
 LWiitqRb7uiqDiKkmhNCBDam57eFGut1q7X68gBkdvjn0L9WwiE2kJwqv7W7VpjCOdcX/70hQVg
 qKpl+41Y3rnL87xjfqnxL5v6yo4MaHOXRP7kbZB4JL/EYHtxAKEsuscVQiQGFujYe6QXX248Ctj
 UOh7AhT677fD4ckv+KEUBhLYFKyi3QCUCTJw9yIYwFSiPYhN31cf7B/9Et2uxTFeIlzXkEwJSy/
 3YKzyD
X-Received: by 2002:a05:690c:a694:b0:80b:9f4e:a70 with SMTP id
 00721157ae682-8712a70a30cmr36642557b3.26.1788560582577; 
 Fri, 04 Sep 2026 15:23:02 -0700 (PDT)
X-Received: by 2002:a05:690c:a694:b0:80b:9f4e:a70 with SMTP id
 00721157ae682-8712a70a30cmr36640947b3.26.1788560577339; 
 Fri, 04 Sep 2026 15:22:57 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-871439c4566sm28368627b3.4.2026.09.04.15.22.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2026 15:22:56 -0700 (PDT)
Message-ID: <16bf2542-b9c8-4a1a-ae95-992c0e168ea6@oss.qualcomm.com>
Date: Fri, 4 Sep 2026 17:22:55 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] target/hexagon: fix HVX scatter/gather
 region-length check
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
References: <20260904012233.3607547-1-brian.cain@oss.qualcomm.com>
 <20260904012233.3607547-3-brian.cain@oss.qualcomm.com>
 <63513430-7bd1-486c-b693-49d1076562ed@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <63513430-7bd1-486c-b693-49d1076562ed@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=baFbluPB c=1 sm=1 tr=0 ts=6a9b44c7 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=Bsm96ptRnNhaWsWVLtsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: MDIAuPIEG7P_AjJiZD_zw_nWYYnMp6TI
X-Proofpoint-GUID: MDIAuPIEG7P_AjJiZD_zw_nWYYnMp6TI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDIwNyBTYWx0ZWRfXygxx000iEAEt
 ky94J+XHx/ZQkVJwtUtCv7RQhclGpkrvr7TZAhs0O8nXR4o+3pRRhBwcC/WpFVZWf2iVGIVSfL9
 6HPlwFownv8zQV1MqHTa9hIPU5j2uOQMP+f2sR2GkDxGRAj1R9jilJWsO32AUpb3BPKd8oGYO06
 INr0Tnu175GrBhDTu4ydJLHjMSh0IYxplmwp/3fJSlF4O1wCT8UayTxTEg+LZFy2T2cT1i04CNf
 jVNJnoD3IEmKEtYEPcd3dpczeasNIBH88hk69ck+PpT4oIRPLzWPHslvkvjtyITXl5d6v1EnlqQ
 +1aS0FaMCQuIFIZRfoZ/VcHNqJ6lKOAL9Uo5j/C1T/eqbAjcShN+TfcuaZP5pVYDulcyhK4v1J8
 l0jVT3YhfjelOKFLoDJkk2k/K0JbVah6FqDnrk7i57koddUiGUs9GQv7Iw5Yft9yc+SJhjvqZyD
 Qck8bLhE55XdaYmjEWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDIwNyBTYWx0ZWRfX/ZIOCqBjB0wC
 4a0V5n+FTNAEG7vSCe0Z+rRyPfyYHlxK59j1MI1WVsw1C05cD0qe6FyCNFGtMcgOU5cC/0G8opD
 2QcOaUpeRpCeA+hlt8T/0H+4HGlFKU0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_06,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 spamscore=0 bulkscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040207
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


On 9/4/2026 5:33 AM, Philippe Mathieu-Daudé wrote:
> On 4/9/26 03:22, Brian Cain wrote:
>> The region-length bounds check compared (EA + i0) <= (EA + LEN),
>> which reduces to i0 <= LEN and never actually depends on the region
>> base. This let vgather/vscatter keep elements whose offset was
>> beyond the declared region instead of dropping them. Compare the
>> offset to the region length directly instead.
>>
>> Only load bytes for gather lanes that are kept. A dropped or
>> predicate-false lane must not access memory and raise an exception.
>>
>> Reviewed-by: Matheus Tavares Bernardino 
>> <matheus.bernardino@oss.qualcomm.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/mmvec/macros.h | 31 +++++++++++++++++--------------
>>   1 file changed, 17 insertions(+), 14 deletions(-)
>>
>> diff --git a/target/hexagon/mmvec/macros.h 
>> b/target/hexagon/mmvec/macros.h
>> index e85beed3387..858afd995d9 100644
>> --- a/target/hexagon/mmvec/macros.h
>> +++ b/target/hexagon/mmvec/macros.h
>> @@ -130,9 +130,9 @@
>>       do { \
>>           int log_byte = 0; \
>>           target_ulong va = EA; \
>> -        target_ulong va_high = EA + LEN; \
>> +        int in_region = (OFFSET) <= (LEN); \
>
> I'm a bit confused here (and hopefully wrong), shouldn't it be
> (OFFSET) < (LEN), otherwise the byte accessed is out of the limit?


Yeah, it's confusing as-is.  I'll change the code to make it clearer.  
s/LEN/OFFS_REG_END/ should make the code look more conventional, I think.


HVX PRM 
https://docs.qualcomm.com/doc/80-N2040-54/80-N2040-54_REV_AB_Qualcomm_Hexagon_V73_HVX_Programmers_Reference_Manual.pdf

Refer to section 5.3, "Scatter and Gather" Table 5-3 - "Mu: Byte offset 
of last valid byte of the region (for example, region size - 1)" - the 
Mu value is what's been interpreted here as "LEN."


>
> (pattern used multiple times in this patch)

