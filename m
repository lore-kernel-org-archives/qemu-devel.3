Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C090CCD98DE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKGr-0000qY-Ed; Mon, 15 Jun 2026 23:15:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZKGn-0000qA-3C
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:15:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wZKGj-0002AT-RI
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:15:20 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65G1xlDF1690900
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:15:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GLUVqZxGqA7FDCAfbLW/t3tP9KqzTJqGEOQ8iSBXLnc=; b=ePgbG5HtiqkpcGag
 dV46roD7kqIwczH3GPp4q7V5+UUEJU3hkmEEwI0BpH2kTYL1k8pollbA6QVm4gqI
 L6Xr5fsUzO2m91mZhTxMGPN3pZipoiJskZBqtgNcd34tQNXlfMi3kPkuzG0q8P5R
 2PNncB+UcxirRP0lRaALQZVUTuDLdPyuy9SXiDIBuKmOWoEnC6ZZipDrv7JCzYgK
 j3FFG31MocLlbFlbaQEU6rpjsykLIRZG/o00xMIyVoBhUE76+Ps6zgB7ejRGiqj6
 vINfpFSpj1mbgtVZcyZ0u22p/pCs/hMBDUf8XgSEd5FbToA+6jppy6zQmQU/kDLj
 cqPZ3A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etetjvfwu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 03:15:15 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-915767b341eso393738585a.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781579714; x=1782184514; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GLUVqZxGqA7FDCAfbLW/t3tP9KqzTJqGEOQ8iSBXLnc=;
 b=Bpj8qUXePCMN/LFpzgtT4vzgDyNJPdwmbx6K2CbrXyonN6Y/y+LIgONJ917LoQittg
 NIzNZrG9jnL/d0S6kCma1+TI520JQnjMudgUk4k12ZmVLHizaEhGQ4HaCbKE2vqToe2E
 x/2+GQVZ3zkSFKFLEoB133hPedeCzbuNb9YHg3tBM+VSwgL/0Dzeh/ArydCj5grVYal7
 1BMz4oKrBZwzQn59i4LjcuNdsZMPjsAsRARADvCkspNcehSMyR0Le3OHocYDzorM+GMN
 T0L1klG4G0U421WmI4uQyGS27Sa/ASwb0OWGfI/p31dsIwP2bz/0XXqu0urgECBn/tDG
 0nEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781579714; x=1782184514;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GLUVqZxGqA7FDCAfbLW/t3tP9KqzTJqGEOQ8iSBXLnc=;
 b=J8lsjhD656AfyumY0ziN6j21pRUL265ziD0SbX7cII7jZ8Um2/KzkdHtmyJ3/XTJM1
 7yMu32Ro39emFgjID//VOoNTXMuk2258frsgabwXpflv9S3x5zZyzONL4SrypUa80ivi
 wRKwtNKlXed5GkQ+bdqIIVJyoIwOw6wVdQXyL9pMtkVpKo3hjnNB4/f8iyKvWJOuNrHI
 4BLrwdzJlnyYsl1Rg8rNRRjvux81+zJPeeIUOJwAPOx+4tbHNKYx6cEEsFJTbxOHA4Nd
 0/gJkEhdsH6l0k0VkVCjdj8C3ZVOiU3DTmZZ29S0DqSabSslmWPuoAF+uyQBzUtaGFSZ
 tQ9w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+n+xF0swanzulXh3GPl0FDlOn6xGiaTr1tefVYciRhYnFITpKhUjXD/LoA8zEl9vEqOrGLFa2KEEyz@nongnu.org
X-Gm-Message-State: AOJu0Yx6AAfNO0I5diHeHJfIOBjGr7Od31OlyZsqtFn1Q0ra5yn9Gi6u
 dHE9j/3WCVBR3nDiplx3wDVP3ypn1UESfaJ0u20FvdY6vY4yKSA9nR1ihWis6XEnVwGL2KYllPZ
 utaDmOTc7EYauCDG33sqQJjLkDeJhNf2Q6XZW6awRZ9Ne312CAOGswG2yGA==
X-Gm-Gg: Acq92OGjIWuexgFtTl3vOuB2J7BsyGFmt3WqcTUmUWgK4arzDPLqZfOMva6OpPz0l6Z
 AkxGMrPYvW8Idx1vnrNr5uRVgkZYPE1w+qWOrjRnqWxNBXW5WD4ZATPkLgGym1+9QL80QO7Ta9k
 khshFbtieDnDYX1k0cD+KYMUq+5SGcG+UIrRmglnV6U1Lt6X/AdMv6RfLMcS8UXTYOQGKTjKRg4
 Txe5xajv87E9MDBeJcTa18Q8owPCo87GIyhy65g5wycVEJr/4uYUn6X6jrNpGpNQyOG/v5cLo6v
 evF8s4OBMoDu2RvYKc9MoZP5idttBsZSjbM1m9pFyKcIAdr1HyM4zLBOrBk+kt46AiPhPJPqzhL
 VoLi2NZKlay0Fi+WI6XkDsyrnsm+aAajZryCNQKitXy46a7+Mab3gZq0rzmHz8wXlYy2KUU+D
X-Received: by 2002:a05:620a:270e:b0:914:e3dd:17d1 with SMTP id
 af79cd13be357-91c454144c1mr247490185a.11.1781579714189; 
 Mon, 15 Jun 2026 20:15:14 -0700 (PDT)
X-Received: by 2002:a05:620a:270e:b0:914:e3dd:17d1 with SMTP id
 af79cd13be357-91c454144c1mr247487185a.11.1781579713691; 
 Mon, 15 Jun 2026 20:15:13 -0700 (PDT)
Received: from [192.168.69.214] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a4f8d7sm23001015e9.5.2026.06.15.20.15.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2026 20:15:12 -0700 (PDT)
Message-ID: <f3724a1c-cd1b-4651-9a8a-91ca4945f087@oss.qualcomm.com>
Date: Tue, 16 Jun 2026 05:15:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] meson.build: check MAINTAINERS file is consistent
 with source tree
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com
References: <20260615201723.2959015-1-pierrick.bouvier@oss.qualcomm.com>
 <20260615201723.2959015-3-pierrick.bouvier@oss.qualcomm.com>
 <05604cb4-6f61-4b64-90ce-505ac87d8a04@oss.qualcomm.com>
 <36f118b4-8e24-4425-bc45-df2f13651c21@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <36f118b4-8e24-4425-bc45-df2f13651c21@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDAyOSBTYWx0ZWRfX6RXffsEcbHpe
 yPXs5swdNk1qGi4D30uchZRrnui9Kv4mNNEw1TXEHidUxCAHhMPhvcgzgKJU9TUdXaxS1wtMl+i
 n67aM8TFnNvsM1p1jfW7qTgjbMKZG6dKQdz4Gw29vmfTJCizkQXVPwuxKh7H3ShQpjOXIOS/Fry
 57HeGhWJ2HUvrtMrwS5OP5ZI+06uyLA6Zvb2QWUScAlYpZbQnGVZlP3LmUfbKyOiYlyUpbXMVft
 Ro5yipUpCKLkIwBe3CJNJl2tN4KD9Nu4nS2e2H4iiQfytCMZL3kKNSm8b460MXhUPm5JfCgGhF/
 gRT0/LArW0HlQbEts6dgkw9LJdkN14cw1F7/9/HJwKDUX/eSIhjT6d46QM+uy/s2sn/x9CJ1MjB
 IHcYS0/9kthFO/5WxqBhFTyI7C5QvGcMx/EBFikPh2CfAJadDnB9DtcnuhkEx7ZbBpysPOZ7f0R
 4nbUxfSQs6AlFRwcxNw==
X-Proofpoint-ORIG-GUID: 9E-yW18D2kU4HigEzc9nyQ8aodyK1Zkv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDAyOSBTYWx0ZWRfX6+w09prBvgYk
 d9RORm221JvJoPxyrR+2swWJSMnZ6e5/GmqsOAg/I1zk7r2VaanVg0SQCU4N5bDd3wsKec17YaP
 WOmpC0xSPApo0LMCP/Wf0jpLC1jEpPo=
X-Authority-Analysis: v=2.4 cv=HttG3UTS c=1 sm=1 tr=0 ts=6a30bfc3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=rwyCfCsHDfdlQnhIS-QA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 9E-yW18D2kU4HigEzc9nyQ8aodyK1Zkv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_01,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160029
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

On 16/6/26 04:51, Pierrick Bouvier wrote:
> On 6/15/2026 5:35 PM, Philippe Mathieu-Daudé wrote:
>> On 15/6/26 22:17, Pierrick Bouvier wrote:
>>> We add a new script: scripts/check-maintainers-file.py, that will run at
>>> configuration time (and not at build time), to not hurt build time.
>>> This script runs in 0.2s on my dev VM, which has an old cpu.
>>>
>>> We can expect things to be mostly in sync since adding or removing a
>>> source or test file will trigger a configure step.
>>
>> You mention adding/removing but this script only checks for removals,
>> no additions; did I miss something?
>>
> The initial scope was only to check the MAINTAINERS file itself is
> correct. But while we're at it, we could extend the script to check that
> all files in the tree belong to at least one maintainer entry. This
> could have the benefit to force coverage for all new files. First we can
> try to see what is not covered at the moment.

OK. So far removing "adding or" and check_one_entry():

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> 
> What do you think Markus?
> 
>>> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
>>> build things from scratch and always run the configure step.
>>>
>>> With this, it should be impossible by design to have an upstream
>>> MAINTAINERS file with non existing file entries.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    meson.build                       |  5 +++
>>>    scripts/check-maintainers-file.py | 53 +++++++++++++++++++++++++++++++
>>>    2 files changed, 58 insertions(+)
>>>    create mode 100755 scripts/check-maintainers-file.py
>>>
>>> diff --git a/meson.build b/meson.build
>>> index 19e123423b5..57e9c9de42b 100644
>>> --- a/meson.build
>>> +++ b/meson.build
>>> @@ -17,6 +17,11 @@ add_test_setup('thorough',
>>>      meson.add_postconf_script(find_program('scripts/symlink-install-
>>> tree.py'))
>>>    +# check our MAINTAINERS file is consistent
>>> +check_maintainers = find_program('scripts/check-maintainers-file.py')
>>> +maintainers_file = files('MAINTAINERS')
>>> +run_command([check_maintainers, maintainers_file], check: true)
>>> +
>>>    ####################
>>>    # Global variables #
>>>    ####################
>>> diff --git a/scripts/check-maintainers-file.py b/scripts/check-
>>> maintainers-file.py
>>> new file mode 100755
>>> index 00000000000..b001816a401
>>> --- /dev/null
>>> +++ b/scripts/check-maintainers-file.py
>>> @@ -0,0 +1,53 @@
>>> +#! /usr/bin/env python3
>>> +
>>> +# Check incorrect file entries in MAINTAINERS
>>> +#
>>> +# Author: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> +#
>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>> +
>>> +import argparse
>>> +import glob
>>> +import sys
>>> +
>>> +
>>> +def check_one_entry(line) -> bool:
>>> +    return True
>>> +
>>> +
>>> +def main() -> None:
>>> +    parser = argparse.ArgumentParser(description="Check MAINTAINERS
>>> file")
>>> +    parser.add_argument("maintainers", help="Path to MAINTAINERS file")
>>> +    args = parser.parse_args()
>>> +
>>> +    found_file_entry = False
>>> +    found_incorrect_entries = False
>>> +    line_counter = 0
>>> +
>>> +    with open(args.maintainers) as file:
>>> +        for entry in file:
>>> +            line_counter += 1
>>> +
>>> +            if not entry.startswith("F:"):
>>> +                continue
>>> +            entry = entry[2:].strip()
>>> +            found_file_entry = True
>>> +
>>> +            file_exists = len(glob.glob(entry, recursive=True)) > 0
>>> +            if file_exists:
>>> +                continue
>>> +
>>> +            found_incorrect_entries = True
>>> +            print(
>>> +                f"No matching files for {args.maintainers}
>>> +{line_counter}: {entry}",
>>> +                file=sys.stderr,
>>> +            )
>>> +
>>> +    if not found_file_entry:
>>> +        raise Exception("no file entry found - is MAINTAINERS path
>>> correct?")
>>> +    if found_incorrect_entries:
>>> +        raise Exception(f"incorrect entries found in
>>> {args.maintainers}")
>>> +
>>> +
>>> +if __name__ == "__main__":
>>> +    main()
>>
> 


