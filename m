Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6159EC5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:12:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvtNV-0004VP-CG; Mon, 17 Aug 2026 05:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvtNT-0004SU-Aa
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 05:11:31 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvtNR-0002qR-LJ
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 05:11:31 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67H8Zk2f1323841
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 09:11:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DTSQVi82d9gOoslAC16QJYqXxNW73peCjzd8YLfnFqM=; b=FLQNAPivfGSTes9Z
 IoKLaf1QfbSjFOgNH1BSJkeExFfzjZ8a0+TIKu8cMsFr71ftY27bf550y5JVhIh7
 HSc7Y95C6Vb0j+5SPTlaefy6u2rs/8iSTNC+bDV904UAeF42MJHteq6OBbPTwDkP
 Q9JD1PjDZ1r+nvp9GrXrmvy6OukpDX/IBehkwSyKcPfuzzy1M6bcw7V0B/MnGHvu
 GT0rqs6DfBY7AyhOxi2yGaZR9O1mw6pSAaVZTB/7QL6Euu6GqeYnNR6WuJ++mCsk
 lid9HCx8rJEMYdQz3mZ4Ol/WEeSlT/DdmbUnSHmxc3x9id5EDAg21Ic4RixPOUBD
 JvMnSA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g3xx7g593-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 09:11:27 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ef13b61bcso456678985a.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 02:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786957887; x=1787562687; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DTSQVi82d9gOoslAC16QJYqXxNW73peCjzd8YLfnFqM=;
 b=JOS5K8S9HC9buPaBvoAhGWRSrpN/XCMny5Et1GABMr0p2oUp1fdqD7/io0+Cijn+oT
 40T6jfVBHThoNTitJoVq6ONxHuJrTX1tcYXmePN6Tgx062Hg8/JU7QPBdDF/vCh6RAdd
 qD3waJ+4V9xj5ItFE3OVJkyCDmH56fwG12deyYhD/3j1FjJFWSPcH+rRXXbGHYWeMEnn
 OYf+zCS1apfxNrHenmq/Y+LgddtnbZA4PalBph0i7yGbzoGRAFWNzed12pPc9+Y/du4D
 K54MjAKzmWDzkThL4hI8PKuD0trPAweW8MnBsqWktx/h/QSAsAholF+srkj/ObDpY0Fk
 R6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786957887; x=1787562687;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DTSQVi82d9gOoslAC16QJYqXxNW73peCjzd8YLfnFqM=;
 b=E1jNAqA9d09aaOAV/hTziDMYLBJPPtESMTWmwIwpmdrT/5kCZBF1forgVFJe49jjnT
 PvrSBzWm3xC1n5ns5p+B6L8Qri8NrNg35+FRkcBDRnaD4Kq3wAMOdlwDaUd0Ix13pff7
 f21xaAmTQeTcaZjapY7G/jZvfs0mQvmb3SQr3qT0idoP0PWMa8TKqRo4AxuuCTqEr27n
 B2cSqvpn5/iEiCrdCNTPmkm22+U8YXeOkhASHMAo83ipz9+BcfwX5o3lVDjgmSoMqnUe
 +dA9HALyJcROP7z0ieWPB68YHj/ur3h1YIea11/tPHCz2fHWLifqetWLFXGj+tw/VOOf
 bC6Q==
X-Gm-Message-State: AOJu0YxRUZ+af6ohc0MgYcCT/dHGBhDar61FuXq2WDlsaZXWyeWZqSSx
 i9oAovc7B9B0fBnw3sUwzIzAMFnkTJNmcpqPwevMymP8yyF3beFEs0fYhMAwggYEJ+pZKtOP6Aw
 O0BkrZDOYWJ/kce7CP/7byCL2Eh0hR2wffGGMufoq7777xxAiNQ9Bw+VTfA==
X-Gm-Gg: AR+sD11N6ANbTOVcASIxjuQ9G9BRuRaurPi2w8BnYbFzzTtS9w/UkM/z00sS6UAuASk
 C0JO80pwnGfUGsUIRE/NC1J1027z4/atjU432skW935nb36x/cfhB3BKjYW3ID7oHLVPdIVQMhI
 E7TQMKEe28PO3y5bQB8ztglhTcJyyZJ/qV1dhnokll9nRSBkw+fqqaLxVMJcJ6GitR4dun3JHkJ
 cYhsvx5brcAjMP2FKdk6abhUuZmo9ZyXkMayhZ19E5A/AnQKEQhnlHAxQrp8dtPBcqNvdCHwm1v
 5j60wa5oMFsNEbSe0zo6VaQKMtP5/qepBfqzTIBYCgx6VdjqUiP21++hcb0dDNqw5If8EQs9Jes
 2qZf0L7VYmO68wCio1M3xDhaFm5NrR0kLMcw=
X-Received: by 2002:a05:620a:ac18:b0:936:bcd6:269d with SMTP id
 af79cd13be357-936d21427c8mr2218678585a.6.1786957886579; 
 Mon, 17 Aug 2026 02:11:26 -0700 (PDT)
X-Received: by 2002:a05:620a:ac18:b0:936:bcd6:269d with SMTP id
 af79cd13be357-936d21427c8mr2218675085a.6.1786957886123; 
 Mon, 17 Aug 2026 02:11:26 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499877d5548sm211327225e9.1.2026.08.17.02.11.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2026 02:11:25 -0700 (PDT)
Message-ID: <36f6dd7d-1b14-4c8f-89d5-2e8cd34cee7d@oss.qualcomm.com>
Date: Mon, 17 Aug 2026 11:11:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/49] tests/qtest/qmp-test: don't depend on
 human-monitor-command
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-13-e53fc35bc550@redhat.com>
 <d7121bfe-a2be-45fe-b933-70190e6a369c@oss.qualcomm.com>
 <CAJ+F1CLhPJiWQR5JsYPCfKpugx3zvKAXDZkM=5vjSdAbNr3+4w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAJ+F1CLhPJiWQR5JsYPCfKpugx3zvKAXDZkM=5vjSdAbNr3+4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2OCBTYWx0ZWRfX0SPmO6Tf7xTp
 sbkQAaQxQ7JUQ19qkPHMF4hLuOedwjXhqF8Vjqy8FKG3R/pDlk6VxTLV4NL9EnrWvYIbYLmJKm5
 wkWUnOHTWlMZd9jIF/Yw39fdCeo4d74=
X-Authority-Analysis: v=2.4 cv=TK91jVla c=1 sm=1 tr=0 ts=6a82d03f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=MlMmjxFhlnC5T0XeoJ0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: g-Idg8znM_shWps0wXaFkSHxHG1VSWiA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2OCBTYWx0ZWRfX/xs0Q9o+Hv7w
 3IJzQDCXEipB/Dy5s8ZCueG7m4aBoUehOyywbhkcMQ7JQKGFS8V9G2zIJbIBOKotGifSwYWy/oB
 s4okb7R6aRTNRZPk5OsG7sbWJMulTROXRxLFXqkggnp7rOEvGbO58xN2HlAxIVjR4rftr4ew10i
 qyyi6Hx5Vqd4gPLm5tSnIXV6tg3qvkj3HpRqhCvnhum6TM+DtEuqTzlnb5fLYCYtl8HyP/M5YAD
 QHr4SvYQbISQ4RR5VJ/PdS9rOVojs71m8Xvo+SGd9ziEoXGOd3mKSIZmit+/0uwEhm4a/1f6QlI
 UJEI8h9+G2Ho1BWW1lEmu9DpH7HGPD7lQCfN7sf7GjqGcziXL0LE5vsrYw7+PPNpWr/woajGRPO
 0BtcqxBpysR85mUeB4YiFSONawzTv4iy+WVcaF5Id5vMJZDeBWwP6cO3JphqGDp6Fzr3RLbjQbO
 j9noI+SdxAYZW0bvd0g==
X-Proofpoint-ORIG-GUID: g-Idg8znM_shWps0wXaFkSHxHG1VSWiA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170068
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 17/8/26 10:11, Marc-AndrÃ© Lureau wrote:
> Hi
> 
> On Mon, Aug 17, 2026 at 7:56 AM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> On 16/8/26 21:12, Marc-AndrÃ© Lureau wrote:
>>> The test was using 'human-monitor-command' (which requires HMP) to
>>> verify that an integer 'id' is echoed back on failure. Replace with
>>> 'query-name' for the success case and 'block_resize' (missing
>>> required args) for the failure case, so the test works regardless of
>>> HMP availability.
>>>
>>> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
>>> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>    tests/qtest/qmp-test.c | 13 +++++++++++--
>>>    1 file changed, 11 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
>>> index 3a325a04e07b..927ab053f8ab 100644
>>> --- a/tests/qtest/qmp-test.c
>>> +++ b/tests/qtest/qmp-test.c
>>> @@ -151,9 +151,14 @@ static void test_qmp_protocol(void)
>>>        g_assert_cmpstr(qdict_get_try_str(resp, "id"), ==, "cookie#1");
>>>        qobject_unref(resp);
>>>
>>> -    /* Test command failure with 'id' */
>>> -    resp = qtest_qmp(qts, "{ 'execute': 'human-monitor-command', 'id': 2 }");
>>> +    /* Test integer 'id' is echoed back on success */
>>> +    resp = qtest_qmp(qts, "{ 'execute': 'query-name', 'id': 2 }");
>>>        g_assert_cmpint(qdict_get_int(resp, "id"), ==, 2);
>>> +    qobject_unref(resp);
>>> +
>>> +    /* Test integer 'id' is echoed back on failure */
>>> +    resp = qtest_qmp(qts, "{ 'execute': 'block_resize', 'id': 3 }");
>>> +    g_assert_cmpint(qdict_get_int(resp, "id"), ==, 3);
>>>        qmp_expect_error_and_unref(resp, "GenericError");
>>>
>>>        qtest_quit(qts);
>>> @@ -487,6 +492,7 @@ static void test_qmp_monitor_remove_cli(void)
>>>        qtest_quit(qts);
>>>    }
>>>
>>> +#ifdef CONFIG_HMP
>>>    static void test_qmp_monitor_remove_hmp(void)
>>>    {
>>>        QTestState *qts;
>>> @@ -504,6 +510,7 @@ static void test_qmp_monitor_remove_hmp(void)
>>>
>>>        qtest_quit(qts);
>>>    }
>>> +#endif
>>>
>>>    int main(int argc, char *argv[])
>>>    {
>>> @@ -521,7 +528,9 @@ int main(int argc, char *argv[])
>>>        qtest_add_func("qmp/monitor-chardev-in-use",
>>>                        test_qmp_monitor_chardev_in_use);
>>>        qtest_add_func("qmp/monitor-remove-cli", test_qmp_monitor_remove_cli);
>>> +#ifdef CONFIG_HMP
>>>        qtest_add_func("qmp/monitor-remove-hmp", test_qmp_monitor_remove_hmp);
>>> +#endif
>>
>> Should we re-order #26 "build-sys: add 'hmp' option" or add a temporary
>> #define CONFIG_HMP?
> 
> Let's add a temporary CONFIG_HMP, rather than a temporary non-working
> --disable-hmp. That should also help with ordering of other later
> patches which may not be optimal.

LGTM.


