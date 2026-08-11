Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07322C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 18:37:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtrLL-0002N1-N2; Tue, 11 Aug 2026 14:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrLE-0001rK-W1
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:36:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wtrLD-00033q-E3
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 14:36:48 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67BGOKea859118
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7a/W+rbCj2Q+fQRf9c3sduMpvLYDl/0EcPrsRTWe5gc=; b=bp4plw754NokpUT/
 omZ6jNm/lmPrQ/CU+GVDJ4MghvaL3jcPbCmK60a5TR8VWLzTbR70//HlAEMFH5FY
 SADrp53gBHStjK6bsjQxVCgAaupOp77SYwfb4hkFg33SYr5YLxZeb+dWh8VWDEW2
 lOcp9ae5RGLxr+kW31q+OfaW75/Dk5CtGPaw3dsLPolUA+Ee4kxjC0lcNxSi20g4
 00YD57QBBcmhL3Ag8S6LYm7SPe6DN6Zg//AJANDyZbTD3MsZvMDQA2ltSSJLbiZ3
 r+cRvrvdet48/Woa38fTOQdGYI+/fm0FA3gghKzq6aXPQOV1C44hv7owwGnEZBCi
 V2Vfwg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g049mhh74-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 18:36:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1d30035dso2127371cf.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786473406; x=1787078206; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7a/W+rbCj2Q+fQRf9c3sduMpvLYDl/0EcPrsRTWe5gc=;
 b=U3TCGLxG+vOsasXlWAMCDzeM6yaBQnn9YmMtTB1KR2Ud8aQs6FygUiJlnWLW+Hs1Tz
 emYMtlADrTALc1Bpqt1LL9J6KBxlszXTgz113TZzQ3FFAPr3OqxZwUJ7c++MOJgIZjWE
 BFiU+Z9BPVmZ77mSBaFqbTRiFRjHtB2MAnxSOi5P+MolI9h7mBL10SGzdyZhCIqrxeka
 UjNPk6c68+sYRL1fT6Ml0wt6GBy6RDG7i17oa3ygWqtf9yM+HKV5MGo0ZgDdOHKEEC+/
 HGPCaT1CJfNCtKttgYTrf+b0UJFM4MUAR/lvhSdr7ji4miDxvWvyuvJPhHvWJYIFQ923
 BPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786473406; x=1787078206;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7a/W+rbCj2Q+fQRf9c3sduMpvLYDl/0EcPrsRTWe5gc=;
 b=XXV451O/Q/geWBYWx9qzppZCcWadEbl+tAujh0BQvTsQZb7l82C1NMEHe1pc8CepVE
 RuNG3CrxC5LjU+SiSHtzmAxbpZTeMmNG93snbj/0RN3bImXOuJcUipaqXntEzkvWsoMq
 RT/PlGI5VvZGSDADnV0aefRvPICpxjDBvrFhvPzC02Bzt63YDe5STOSO+UALLcHU8LXB
 K59P3BJ8XYtdCJCPUg3YZw4yw4BWBXIx/Hh6zP7MyTafcF6S0bRRRTa7/xer9oofLctR
 sKEYFtyaBcMIAetVnZdf26Hqny4gY18Qx62/yM6WXeyvkZpIIsqqAaHBJdhZz+7nUCDZ
 kAoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgLXvDh5wvF+6w9/p2tbarGbzIXFPpXIEPQcHlyXhGKXoj5608BNSLV+w7b7vlVvmd0sTDrADY2Q/m@nongnu.org
X-Gm-Message-State: AOJu0YxIOP5LpsMs+m4VA2XjcqfsAF1B+5tOXV3uYJ7aIOsnN7cZaPxW
 Ysg4zmr6oxOEWO2C7SFOy7u+P2ij0akDgiisDJPmPN+6wVSaJNK8MzZN4QztF7ysOiA/JOYCQC7
 I6oIDn+BkUhYqv5915apkaxCo64OujddFIH2zF9YHAOxbEFxxNqXe4PMhwCW6IGZcjA==
X-Gm-Gg: AR+sD10zeFGdEdf1UOcwWkhpGQVb4amwzj2M2K4qf/iPaDqVE1r9Nb/429vnh4kgLoX
 T13j6XID6rwG8ER8x/JC4La25iIUaOeQg1WvWamIgbgJjHtsC/zPJNXnOofWoTAsbj/0nDTD9zG
 5k4Mf8c2BozgX3ubc4QH779eRxIJRgydMcdsgsyl6jDRTs+BsWhTxnVy9iI0b0OkuTWSdU+8o+8
 OAdOknilUPsL0XbtbdXvpGKpHE7SbtjN4eHJr0ZRdx3yNQuSWeA/D209bXW7cI/R4zUgq/CJDxn
 pHwF005o1votFaCBiC3POxcRuhx/nmKCHDto4aa/389RxL190To8sGD67Mi9yK63hxX9O2Li7zv
 UeopkbcLwFYiixt3688fr2P9WUps+aRhO59U=
X-Received: by 2002:a05:622a:11d0:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52d584aa4aamr45297431cf.9.1786473405647; 
 Tue, 11 Aug 2026 11:36:45 -0700 (PDT)
X-Received: by 2002:a05:622a:11d0:b0:51b:f40b:2fb3 with SMTP id
 d75a77b69052e-52d584aa4aamr45296871cf.9.1786473405071; 
 Tue, 11 Aug 2026 11:36:45 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5cba0sm315115f8f.25.2026.08.11.11.36.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Aug 2026 11:36:44 -0700 (PDT)
Message-ID: <2094e036-f7f3-4a56-9158-d4512d43487f@oss.qualcomm.com>
Date: Tue, 11 Aug 2026 20:36:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi
 <stefanha@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
 <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
 <f271fcff-4428-421b-b2b7-472cd8bf3cba@virtuozzo.com>
 <CAJSP0QX8JnTSWHQeQrH5dKHeC4oA9CMTzHAZNhzt_8gKorJ9Gw@mail.gmail.com>
 <3f84a950-d079-4e05-a3c5-daf81672b3e4@virtuozzo.com>
 <7239bc2e-b180-42ab-ae56-454557cb3194@oss.qualcomm.com>
 <20260803180228.GA365806@fedora>
 <CAFn=p-abWtYqGtCbH9XTK62oEPK=vLPjy-scwqR+crXvOQ3RrA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <CAFn=p-abWtYqGtCbH9XTK62oEPK=vLPjy-scwqR+crXvOQ3RrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FI6mjrk2-UbAz_D051zm9M3cfEDuLeiA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfX1vfIb8o97eyr
 TKehp7PKCmy5tuBeL5UMYJ5PEWXm9gY2wFYSnXHsOJ79Jg7bbglCNZGSaNC1ueYKhJX1PtIqzCm
 uL2UIuPLxxNkTyeQnsY226WiTtmtlw+V2qcD5UcS9svLPcEuUeZIXUp4adGsAWX7U6Ds2u/9BsL
 O34ypJvp4S01BPHcqUZblf4i2pBtfTT03H4c33YVAMIdO0zEv5R6nMA9toiqDcYJD2w1tuCx0eq
 CbYw9k9LRnhLrSJkgBXW0KvCtAvlxnmm8WM0DjptMdFn3FCQ97k0WOg4wUCNtua291uQc6ZmQ8Y
 6oL31WhzvFVehe0TTaDKKhYf4PWEdhdBW7eXxMeFgXZ0jV53TlW+PJa7R0/lUxXAuGVPt4YrnqM
 U6boQF0p8LHQMQ4wWKgnWaWNZ+45QmmK+g9S0gDI97up7ZM1c9rzjjJGD9lbsOLLYe2P2+qSZ4B
 8imRCQmTWou1954yDpw==
X-Proofpoint-ORIG-GUID: FI6mjrk2-UbAz_D051zm9M3cfEDuLeiA
X-Authority-Analysis: v=2.4 cv=FbkHAp+6 c=1 sm=1 tr=0 ts=6a7b6bbe cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=TYBLyS7eAAAA:8 a=6rqHouBjAAAA:8 a=EUspDBNiAAAA:8
 a=8yEsTp4gmuAH7ZDILjYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=zvYvwCWiE4KgVXXeO06c:22 a=Hx1yvPaMooE3kwe23bt7:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE1NiBTYWx0ZWRfXxgDZNcTK6V5q
 yC6SaPkYpaYJCykYRgkyVkthWep8Q92bMvnW2jQfbhJ0g/uaH/KXX1OvpKiDaOCKhLF95n5qFmI
 XVYGBBJ64rbpHppDIewZ34UJmYAmgAw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_04,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110156
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

On 10/8/26 18:51, John Snow wrote:
> On Mon, Aug 3, 2026 at 2:02 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>
>> On Sun, Aug 02, 2026 at 04:13:35PM +0200, Philippe Mathieu-Daudé wrote:
>>> On 31/7/26 23:17, Denis V. Lunev wrote:
>>>> On 7/31/26 22:18, Stefan Hajnoczi wrote:
>>>>> On Fri, Jul 31, 2026 at 9:45 AM Denis V. Lunev <den@virtuozzo.com> wrote:
>>>>>> On 7/30/26 16:55, Stefan Hajnoczi wrote:
>>>>>>> On Thu, Jul 30, 2026 at 4:14 AM Denis V. Lunev <den@openvz.org> wrote:
>>>>>>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>>>>>>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>>>>>>>> CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>>>>>>> ---
>>>>>>>>    MAINTAINERS | 1 +
>>>>>>>>    1 file changed, 1 insertion(+)
>>>>>>>>
>>>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>>>> index 902db77218..4628793dde 100644
>>>>>>>> --- a/MAINTAINERS
>>>>>>>> +++ b/MAINTAINERS
>>>>>>>> @@ -2160,6 +2160,7 @@ F: docs/specs/edu.rst
>>>>>>>>
>>>>>>>>    IDE
>>>>>>>>    M: John Snow <jsnow@redhat.com>
>>>>>>>> +M: Denis V. Lunev <den@openvz.org>
>>>>>>> Waiting for acknowledgement from John.
>>>
>>> Note, Denis is not removing / replacing John, but simply
>>> stepping up to co-maintain an area unattented since quite
>>> some time. I doubt John will oppose to that precious and
>>> scarce help.
>>
>> I don't think so either, but he should be involved in the process of
>> adding a co-maintainer. There is no rush, let's give him a few more
>> days rather than making the decision for him.


> Please, please do go ahead and take over.

Thank you John :)


