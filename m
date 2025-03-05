Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2A1C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 14:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpqAm-0002ad-3s; Wed, 05 Mar 2025 09:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpqAk-0002Xz-HW
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:56:34 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpqAi-0003Td-Ct
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 09:56:34 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 525BMeaH007243
 for <qemu-devel@nongnu.org>; Wed, 5 Mar 2025 14:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PioQ5undYVeEE9b0UYezdduIYqmaDGeuu0d+xdqMB/E=; b=lc+PpELY6yQs5QCa
 DLnVq+J2xtpCNKJvWzz6/HGN8jHz3nvu/E/azYw18AU4V6RnL7I0JoJiC/uh9AOk
 JzQ4A1mZeWWw2g9o+s0/Hg7Bro/gYScQSdTXrAZ3mRfj2J9u+XbitNyIKQDQdFo0
 MldrusAKF2N8JKcfwMP4YkfPn8c+WQ9snHZEU8C1BSgXw3wCP2SHh/SY1NZGHbaZ
 ZGMu6A6HibBn+xLQVM+EZ0zBJZNVHU8HcUANqolkHEfqRwGGNCHh+V9IT1u/YdB2
 gqaGzSShDdXsRtI56mR6AO0cPNAiFx5brjpvzOFbivkazDvsS6SwT9J+tEffuRGY
 mcPtyg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6unmbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 14:56:30 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-474f34b32a6so56346891cf.0
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 06:56:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741186589; x=1741791389;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PioQ5undYVeEE9b0UYezdduIYqmaDGeuu0d+xdqMB/E=;
 b=gGqKDQhHBGvythXVo+caByeD58Pw41mbvEqC9GcGsSnDUd6qpA/PPbZuMs+D+rePaV
 HnWHsBMJvtQ77Rj4pDZ2AshSNw3l8HHfqa46tEWIJ8U9OchOiY752f/DTFpD0F9uGWBe
 WcbjgK+slNhlPx765ll894XzvuwJhGnAj2gwaE39py9Lpp4gZ1cqBDM9Bks3IDu5JYHN
 k6oGHieVolA0J7zSS8glIoFbmijBt70uH4lf9f+9seT1BK3PP+LcOpo8NQ6LkCgHpAAE
 zqfmkVEsmyVlJnMbjknv8jdzwDjzwFxvGtV48UmP3dBHekMRfmYSRMRHreRvjhoMLJ0Q
 HZ6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0VGmn++IbQTsMeyV3ycXUOXvmbKrf46oswEH8ttgUi6+BawxRrkXx37L51AMVw+gOGYSNvTn9D/jV@nongnu.org
X-Gm-Message-State: AOJu0YwG4e09NpJhgeI3NgvvCe9v3IZCPC83mCWbryJlYJ65HcT2b1N7
 X6XNOx97y5xFM2rkg7OimFhVBYp8Nm8lt9qJ8GnHTyyc4y1OlwsxrIavagPw8HSpJMkbJBGekAf
 rTu93pJT4Aih5IZq5WHY7y74ernlLXew8BvJFspNGzqZhg9GhylUUTQ==
X-Gm-Gg: ASbGncs0f3VcnrM4ZH3SyVCO24rUDY05s/ByttvovH8xpupmpQW2uj3HM8S+4A8ozkt
 kc4aQ5PzNphz3TQIywH6fY476/Eo65OKy+QRcrT48HHOoyFhqZ+mUC++JqtiH5oxzYJRdTEa64Z
 CE06L6W0a3vxYTOoDGi75zgv9p4k/wUv7FSXPAc90fBLhAw/wehAACbdNZv4nXMv6y2vyx9KJlE
 kk1MOwodWroydeeNO9VDs2g/I4VhpdzDc4Y61V3rzmSnc/wmVB4RTJ01PwoLk+4K9sVcsMw0p2a
 pwC69/UF+8lYVIubxGGzlJlE17leu977dt54UlG9m1ov0h02qNWzQ+BIZLymi+t9PkuPrfsgj5M
 u8883x9911y/aZJPh
X-Received: by 2002:ac8:580f:0:b0:472:614:19a0 with SMTP id
 d75a77b69052e-4750b4c7ef3mr47681341cf.35.1741186588615; 
 Wed, 05 Mar 2025 06:56:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvZp/+KJCgPHgVccM+e4r5j5/E6emWLjBqHRq4y5MBestKqpcIgHXExvEtM+Y9Q6/0W6nQaQ==
X-Received: by 2002:ac8:580f:0:b0:472:614:19a0 with SMTP id
 d75a77b69052e-4750b4c7ef3mr47680851cf.35.1741186588194; 
 Wed, 05 Mar 2025 06:56:28 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4750c7ba271sm10308701cf.14.2025.03.05.06.56.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Mar 2025 06:56:27 -0800 (PST)
Message-ID: <2de21adf-204b-4417-aa2b-2d16d22148f8@oss.qualcomm.com>
Date: Wed, 5 Mar 2025 08:56:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/tcg: Suppress compiler false-positive warning on
 sha1.c
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
References: <20250227141343.1675415-1-peter.maydell@linaro.org>
 <87o6yh57r2.fsf@draig.linaro.org>
 <CAFEAcA9VDtWKoQ09dOt+ZxJ2MhdRTFY_X1ON58pEjYTM_NtZ-A@mail.gmail.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <CAFEAcA9VDtWKoQ09dOt+ZxJ2MhdRTFY_X1ON58pEjYTM_NtZ-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: sQNeAV34qbRpEh1a5wfvxYXI9QzbgtAQ
X-Authority-Analysis: v=2.4 cv=H40hw/Yi c=1 sm=1 tr=0 ts=67c8661e cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=mDV3o1hIAAAA:8 a=NEAV23lmAAAA:8
 a=KKAkSRfTAAAA:8 a=1CxfK888tdwoY2JWDiQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: sQNeAV34qbRpEh1a5wfvxYXI9QzbgtAQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-05_06,2025-03-05_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503050116
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/4/2025 6:51 AM, Peter Maydell wrote:
> On Tue, 4 Mar 2025 at 11:56, Alex Bennée <alex.bennee@linaro.org> wrote:
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>> +# GCC versions 12/13/14/15 at least incorrectly complain about
>>> +# "'SHA1Transform' reading 64 bytes from a region of size 0"; see the gcc bug
>>> +# https://gcc.gnu.org/bugzilla/show_bug.cgi?id=106709
>>> +# Since this is just a standard piece of library code we've borrowed for a
>>> +# TCG test case, suppress the warning rather than trying to modify the
>>> +# code to work around the compiler.
>>> +sha1: CFLAGS+=-Wno-stringop-overread
>>> +
>> Sadly this breaks the hexagon compiler:
>>
>>    error: unknown warning option '-Wno-stringop-overread' [-Werror,-Wunknown-warning-option]
>>    Traceback (most recent call last):
>>      File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 683, in <module>
>>        sys.exit(main())
>>                 ^^^^^^
>>      File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 679, in main
>>        return args.cmdobj.run(args, argv)
>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>      File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 657, in run
>>        return Docker().run(cmd, False, quiet=args.quiet,
>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>      File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 370, in run
>>        ret = self._do_check(["run", "--rm", "--label",
>>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>      File "/home/alex/lsrc/qemu.git/tests/docker/docker.py", line 247, in _do_check
>>        return subprocess.check_call(self._command + cmd, **kwargs)
>>               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>      File "/usr/lib/python3.11/subprocess.py", line 413, in check_call
>>        raise CalledProcessError(retcode, cmd)
>>    subprocess.CalledProcessError: Command '['podman', 'run', '--rm', '--label', 'com.qemu.instance.uuid=5bbb7b6ed2ea4377b9b6d646859ec4ea', '--userns=keep-id', '-u', '1000', '-w', '/home/alex/lsrc/qemu.git/builds/all/tests/tcg/hexagon-linux-user', '-v', '/home/alex/lsrc/qemu.git/builds/all/tests/tcg/hexagon-linux-user:/home/alex/lsrc/qemu.git/builds/all/tests/tcg/hexagon-linux-user:rw', '-v', '/home/alex/lsrc/qemu.git:/home/alex/lsrc/qemu.git:ro,z', 'qemu/debian-hexagon-cross', 'hexagon-unknown-linux-musl-clang', '-Wno-incompatible-pointer-types', '-Wno-undefined-internal', '-fno-unroll-loops', '-fno-stack-protector', '-Wall', '-Werror', '-O0', '-g', '-fno-strict-aliasing', '-Wno-stringop-overread', '-mv73', '-O2', '-static', '/home/alex/lsrc/qemu.git/tests/tcg/multiarch/sha1.c', '-o', 'sha1', '-static']' returned non-zero exit status 1.
>>    filter=--filter=label=com.qemu.instance.uuid=5bbb7b6ed2ea4377b9b6d646859ec4ea
>>    make[1]: *** [Makefile:122: sha1] Error 1
>>    make: *** [/home/alex/lsrc/qemu.git/tests/Makefile.include:52: build-tcg-tests-hexagon-linux-user] Error 2
>>
>> Is it that new an option?
> I think it's new-ish (gcc 11?). On the other hand


I was going to volunteer to update the toolchain used for hexagon to 
address this.  But unfortunately this warning is still not supported in 
clang 21.

https://github.com/llvm/llvm-project/issues/72455 sounds like it's not 
very likely to arrive any time soon.


So "-Wno-unknown-warning-option" does indeed seem like a good workaround.


> -Wno-unknown-warning-option is quite old, and would suppress
> this error. If we do
>   CFLAGS+=-Wno-unknown-warning-option -Wno-stringop-overread
>
> does that work?
>
> (Meson has cc.get_supported_arguments() that we can use to
> filter out -Wfoo/-Wno-foo options that the compiler doesn't
> support, but since this is built via a makefile rather than
> by meson that's not conveniently accessible.)
>
> -- PMM

