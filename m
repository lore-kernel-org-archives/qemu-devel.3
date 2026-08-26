Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7ED4C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:50:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHl6-0004Sh-CZ; Wed, 26 Aug 2026 13:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHl4-0004RB-Hv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:49:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHl2-0006Mm-SN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:49:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QHJYOu1912312
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 El0cjtiYQPBGDTlbrZsN3GuYfKABq6OfsaRiGok/m+Q=; b=Y7V2ScVqU7Aiqz8Y
 KJgY/bMwXYVqEtt7yuyjDqw/ewU57VKqDxfXCLc0EIiPjg7w5H7W5mJbKQmQ+4wJ
 PEJm4gejYjKc5wS2ibkkcGTNuTr36NPyTtzkLiLy+fOcVj9v/dVMAiOVKtmRGc9Y
 Oi3nKeUhLFEceIToQgy251u6VJtHm7xyu4Ydzj4+Ywqso6KTyLd5cUtvx/41c0QX
 ClTE/r3clMR/srDqi5PwU3xstcW4b/lPm5VlNCJgmrG0cnOhdle3FHZ16v4u0rKG
 Gy1RNIeH8DAOp6TBawzCEijBUp/ITia0ohCoi2n2DG40AR87A1X82zs3fxglLX/E
 DF6jkw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egg3ug-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:49:51 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52dcf1bb6e9so1278811cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787766590; x=1788371390; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=El0cjtiYQPBGDTlbrZsN3GuYfKABq6OfsaRiGok/m+Q=;
 b=W0+rLVSt4gTeNyQZ3zxsZ/6HvGfQEGztndVJosTV7VtC6Vf58y6U/SbtC9HNQMUspj
 AvtjyAwN2IvmZh3MWWrQR8Gff5cCihdRzEiT96Z30AOC172tzXc1CxJQql6GKC7M7bMc
 OMwfAb390ErIo8mWWvUV+IycpnC1V49d1ErR+z0Fp+ACo+5oKACyaG4KRzQmO9M1Iz34
 e6p/lMR1bicxmd13Lp1DBushYhFlz9gmXkRTCVLfVEXzMk/T7xjFyRcWiFT2/jiQ/XqX
 kvk+4kVcM6tNSqEzY9qKakXpKldikxolPwF1PC1wInp74KhYyiBN/9dTkatRFaaylDGG
 t9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766590; x=1788371390;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=El0cjtiYQPBGDTlbrZsN3GuYfKABq6OfsaRiGok/m+Q=;
 b=N8GkamJMol4sRlOgd2qusuw/hzeQP/Rx6BlYLILqi2FN42CQReqa3Y1ebiMbWXlNAw
 jh1+96hNvjNyeVOG7PWnQgl1OesmFUVhHq/WqkGST5/fTBrAJaSMinUc4dQVvLYsgDSC
 k1/8GI45D8JSdWr7NBVotdg8EfG1IN1f9hzdUV2DJ68u8S9q43hMeHTHfv+oxhs+XeXo
 SPF5OhRXY7JECfd6zqazuPC0VjuSyfZ8DDokuEhRYwTIw8JXiiCmwVimgSlX+21jAPRy
 E59t+rGYm6q/EkGNWQJZj0ePDMTCBrYSw6pTAypsG1jdxFPJdVlzRxmLQlW7NZOR4tQF
 yecQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7HIZ0TxAmgCzgCFRRTqBC90EwlcT5/lL0e/n0KCeOdGOs/fnbC1so7W+vjuOCjpCwPJZkZcdAaYcE@nongnu.org
X-Gm-Message-State: AFuF++nxECP4OutQe01c/P1cNyYXgRLP0Jh8tO0yt8/DegyCfVjy+OMG
 +O2Heg01VJBaFiqcTlV3zadT6+X1XZ0Rrl4SoRLnya3qcgUd7q0Lc0952iteiFOsmyfGoFMdfdv
 jVBzXLXoZhnWNiD3Q899tbv1si2mzQijMzXlfTK1PNEQ+wZrcii4IL3bDhw==
X-Gm-Gg: AR+sD12fnwzHHBLakcH3pYOja5BBzb0whBT1BZKB9bz4rNzEm2TJAZQsOg+JoRBFYwm
 arsRA8oT6Odv1X7uNymt1IgOLk2X63Fypyrl+CI6dBexCvWLAT9c+NG1ONv4Gv3nQZWVQdMtCf1
 Nh8tecr6tIRzm3BII+dYWEisuxwIDEQQAjgKHieHwNz/kene8gfSrwVIY/PQOMgeVwUOtNr1reT
 lHMFwTMz8uNo5AT4LQtgH5oa0Y3yE36HvtVi47CkhcY7hyseH2DChMpsuT1SwUs9X17+8+CqdDw
 HW8p/qz73++00vW1Y3pKLPWBv1/Npgy0PeMmYFlSFv00EQhYMnY00EKDfJ9CwNQcv7NfEHm9yxY
 tCsBVSpOvqdP7NBKZhp4AK2DLRjkrGMRyYp+2nj3ezA9C
X-Received: by 2002:a05:622a:1654:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52fa1dca862mr9312991cf.20.1787766590448; 
 Wed, 26 Aug 2026 10:49:50 -0700 (PDT)
X-Received: by 2002:a05:622a:1654:b0:517:146d:2cb5 with SMTP id
 d75a77b69052e-52fa1dca862mr9312641cf.20.1787766590073; 
 Wed, 26 Aug 2026 10:49:50 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9b4e9csm625893766b.54.2026.08.26.10.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:49:49 -0700 (PDT)
Message-ID: <ccaffe72-eac7-4925-b594-5c7c3c716d95@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:49:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 34/49] error-report: switch to use monitor_cur_hmp()
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-34-af60857c2fbe@redhat.com>
 <3c1280fd-9906-4c98-833a-40ef6f0b267c@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <3c1280fd-9906-4c98-833a-40ef6f0b267c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VW4X2Qf6xmlXjnN3Me05cfVNTGKpMKVr
X-Proofpoint-ORIG-GUID: VW4X2Qf6xmlXjnN3Me05cfVNTGKpMKVr
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a8f273f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=4ZTsQeUxgik_RvcviVgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfX9bhnOq2PKGo5
 yHG8fM++EGsGDOGuIkoxkdcwjEZ8kAfNLPN/htahYI20TScM580I4e99F6xqz1unKp+gZM7PXW6
 5oWGQlEb1hB6QufZBSrFdIkVEBBPBWICfZbNB6PM+rZ8KLlES/cjdbcAyAWYkqNqkHkDRgX30Vm
 q06euGJJflFht0s1k70NcLVKntTZmuhJpEf4CMDP7HM4ckQZP6Yu3y28YIMeyUnj+n5rseaNeRO
 qUpmls8idTVaIlntzKe2GOk/636uwPwYuqN5XZzeQngXurqZ7BZ/it79gRcjjN4sxKvS465l/Or
 E3n8Y1R6f7OmzEDJOW+FkEkuE67sZigmJ0snMGWzU/SIiFgeYNIcb6+3VJLtxaGbBjrTlHvKsbv
 iq/Bv8M8t9ywChTIVqxiNJos76lxBrsdAJhWsTSbcOKhnLXpi2Vc/LasMccXClZ4WzXAUg85rKx
 QJHtSUttpn79BWHBBxw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfX4ffD+9KtE4px
 pytHr76hJoYaxT4Cn2bncIL6tXhZQT+qKQO6wql4PIyPh+3v3O81t8FDRzqNGJkAAQBYyRRT8uu
 j5zpt+TujSjLEfyW2ReTXPYM6t0Gfg8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260149
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

On 25/8/26 23:46, Philippe Mathieu-DaudÃ© wrote:
> On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
>> Thread through the current *hmp monitor, a non-NULL pointer is
>> guaranteed to be a valid HMP monitor. Adjust doc comments.
>>
>> No behavioral change.
>>
>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>> ---
>>   util/error-report.c | 69 +++++++++++++++++++++ 
>> +-------------------------------
>>   1 file changed, 29 insertions(+), 40 deletions(-)
>>
>> diff --git a/util/error-report.c b/util/error-report.c
>> index aaa15bc79827..aa278de6646a 100644
>> --- a/util/error-report.c
>> +++ b/util/error-report.c
>> @@ -30,34 +30,29 @@ bool error_with_guestname;
>>   const char *error_guest_name;
>>   /*
>> - * Print to the current human monitor if we have one, else to stderr.
>> + * Print to the @hmp monitor, else to stderr.
>>    */
>>   static int G_GNUC_PRINTF(2, 0)
>> -error_vprintf_mon(Monitor *cur_mon, const char *fmt, va_list ap)
>> +error_vprintf_mon(MonitorHMP *hmp, const char *fmt, va_list ap)
> 
> If you ever respin, error_vprintf_hmp() would be a better name.

If you send the PR yourself, you can do that change locally without
the need of respin. thanks
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> 


