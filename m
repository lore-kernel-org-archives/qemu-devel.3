Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BC0C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 18:23:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x55tl-0000zw-Go; Fri, 11 Sep 2026 14:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x55tc-0000zK-5J
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:22:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1x55tZ-0003Sc-Io
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 14:22:43 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BHWSIQ1292712; Fri, 11 Sep 2026 18:22:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=d0FIyC
 8eO+bpPfzR8LKfJQsNFqtVSTQVE+OvufOLuL8=; b=N+zq9c57ayT/b7VBAaS5dE
 x319BA/YrEHYiyPZhr6mm5HISujERVxk3mmQtqqKOqhUdoO8VN1tw3W8trSLYers
 BJHPvLCeks8/lUAotWqBzdD7zRUvBN3J9pPtJoewWZ8awgKjxsZq3qrYL0upPtat
 9xsUFfpO+kn/WvgEh+Y/0tveyWU5/S8MdFEmBN2KAdeAwWCFrnA24MKVCmvwZzcU
 KyzDbLnMZ6Z+QsKbkwQcAZxLNG6DthxHZwOgcIvKfMr6lRJCpUkBsNEkQbEa8QS5
 /7d3jqIwGT8jtQdbBxlCmi/4SDs86LU+ANcj5fd15vMfEZC9YMi5TJdQoblu2oqQ
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qd7h1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 18:22:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BHZ7F72001261; Fri, 11 Sep 2026 18:22:38 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkvwk7w78-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Sep 2026 18:22:38 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68BIMbvg16515596
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Sep 2026 18:22:37 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EE3BD5805A;
 Fri, 11 Sep 2026 18:22:36 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3941158051;
 Fri, 11 Sep 2026 18:22:36 +0000 (GMT)
Received: from [9.61.56.48] (unknown [9.61.56.48])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Sep 2026 18:22:36 +0000 (GMT)
Message-ID: <9fa18953-3170-4b64-8c3d-412a5b02789c@linux.ibm.com>
Date: Fri, 11 Sep 2026 14:22:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aniket Sahu <asahu1x@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
Content-Language: en-US
From: Eric Farman <farman@linux.ibm.com>
Autocrypt: addr=farman@linux.ibm.com; keydata=
 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
 y8m0x6unNti2MZIUMy0m2gcE
In-Reply-To: <87a4pn8yra.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qXn9UlVfALQVrlyfhQjQg_PsjJxu_Al4
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI1MyBTYWx0ZWRfXx60OnkM0N1Xs
 42Y3pth6HM/5Tr5ICuArOjlODdUbFmauS6gI4WJuAugl5mom/emI+dkD3nSn2cjHLS4ufwKUV8F
 tO85gcRFgHHmQnVu/9465h9rBceFRs4=
X-Authority-Analysis: v=2.4 cv=E/dYNqdl c=1 sm=1 tr=0 ts=6aa446ee cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=VnWEvdzyjQp-O5udk04A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI1MyBTYWx0ZWRfX5L7e4/npUkIl
 Zm4zfN5ollHWywZUf1lu3Do2FEYaS+XtzcyhAeu5VeX6EBw+EVU6aYMUGEJ0BFXf8CD0dhRCo0q
 xEILWPISuLUYabPtug9BOJHuo6Km9TIwZYCQu7loHhJ6gdwJjSb/EUA12tlLoXIUsLGT6L0U4Nl
 unQRbh1rbU/gVP8j6sDhO+MTqzz7/r/5FKoTnfKhMo6fl/INs43nw7pFONQGh0BdDl3zDTqeGIP
 3sBrbBe6dAZu3+517zmA3JOil9xDXlqFyA5Wew8gzvYDJqeawmRhrihrKAUqDXwPfK8wleSfa1R
 Slt1kmRNd54kbQ3i0iHcSUxFAyd0YGVeCpm1Isgr4jbuf7Il/8KochWaD9ZcLOEvl1qaE+MI1W2
 JfIQ8mi4Mx2VbvTlimjmvce2BHMuAH7esIGn0aOqFHXHz38lqYSr0Mx/iY9ho+bHNqWIbb4R7gu
 /jg1yoYmTmhKhsnpYVg==
X-Proofpoint-GUID: qXn9UlVfALQVrlyfhQjQg_PsjJxu_Al4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_06,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110253
Received-SPF: pass client-ip=148.163.158.5; envelope-from=farman@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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



On 9/11/26 1:48 PM, Alex Bennée wrote:
> Eric Farman <farman@linux.ibm.com> writes:
> 
>> On 9/4/26 8:45 AM, Alex Bennée wrote:
>>> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> We have now implemented the same in meson directly, so no need to
>>> keep
>>> it on configure side. Also, we have no more Makefile consumers, so we
>>> don't need to export all those variables anymore.
>>
>> (Thanks, Josh, for the bisect work that led to blaming this commit...)
>>
>> ...snip...
>>
>>> @@ -1659,48 +1299,6 @@ fi
>>>      echo "# Automatically generated by configure - do not modify" >
>>> Makefile.prereqs
>>>    -# Mac OS X ships with a broken assembler
>>> -if have_target i386-softmmu x86_64-softmmu && \
>>> -        test "$host_os" != "darwin" && test "$host_os" != "sunos" && \
>>> -        test "$host_os" != "haiku" && \
>>> -        probe_target_compiler i386-softmmu; then
>>> -    subdirs="$subdirs pc-bios/optionrom"
>>> -    config_mak=pc-bios/optionrom/config.mak
>>> -    echo "# Automatically generated by configure - do not modify" > $config_mak
>>> -    echo "TOPSRC_DIR=$source_path" >> $config_mak
>>> -    write_target_makefile >> $config_mak
>>> -fi
>>> -
>>> -if have_target ppc-softmmu ppc64-softmmu && \
>>> -        probe_target_compiler ppc-softmmu; then
>>> -    subdirs="$subdirs pc-bios/vof"
>>> -    config_mak=pc-bios/vof/config.mak
>>> -    echo "# Automatically generated by configure - do not modify" > $config_mak
>>> -    echo "SRC_DIR=$source_path/pc-bios/vof" >> $config_mak
>>> -    write_target_makefile >> $config_mak
>>> -fi
>>> -
>>> -# Only build s390-ccw bios if the compiler has -march=z900 or -march=z10
>>> -# (which is the lowest architecture level that Clang supports)
>>> -if have_target s390x-softmmu && probe_target_compiler s390x-softmmu && \
>>> -    GIT=git "$source_path/scripts/git-submodule.sh" "$git_submodules_action" roms/SLOF >> config.log 2>&1; then
>>> -  write_c_skeleton
>>> -  do_compiler "$target_cc" $target_cc_cflags -march=z900 -o $TMPO -c $TMPC
>>> -  has_z900=$?
>>> -  if [ $has_z900 = 0 ] || do_compiler "$target_cc" $target_cc_cflags -march=z10 -msoft-float -Werror -o $TMPO -c $TMPC; then
>>> -    if [ $has_z900 != 0 ]; then
>>> -      echo "WARNING: Your compiler does not support the z900!"
>>> -      echo "         The s390-ccw bios will only work with guest CPUs >= z10."
>>> -    fi
>>> -    subdirs="$subdirs pc-bios/s390-ccw"
>>> -    config_mak=pc-bios/s390-ccw/config-host.mak
>>> -    echo "# Automatically generated by configure - do not modify" > $config_mak
>>> -    echo "SRC_PATH=$source_path/pc-bios/s390-ccw" >> $config_mak
>>> -    echo "GIT_SUBMODULES_ACTION=$git_submodules_action" >> $config_mak
>>> -    write_target_makefile >> $config_mak
>>> -  fi
>>> -fi
>>> -
>>
>> Now we're unable to build the s390 bios used for boot (no idea about
>> the state of the other items in pc-bios that were removed here too).
>> Surely reverting this hunk (and its dependencies) won't be great based
>> on the size of this pull request, so what's the preferred solution
>> here?
> 
> Thanks for pointing this out. I hadn't noticed the issue as I guess we
> don't build firmware in the CI. That said on my current tree:
> 
>   cd /home/alex/lsrc/qemu.git/builds/all/pc-bios/s390-ccw
>   make
>   -Wno-stringop-overflow detected
>   -fno-stack-protector detected
>   -Wno-array-bounds detected
>   -Wno-gnu detected
>   -march=z900 detected
>   Assembling start.o
>   Compiling main.o
>   Compiling bootmap.o
>   Compiling jump2ipl.o
>   Compiling sclp.o
>   Compiling menu.o
>   Compiling netmain.o
>   Compiling virtio.o
>   Compiling virtio-net.o
>   Compiling virtio-scsi.o
>   Compiling virtio-blkdev.o
>   Compiling cio.o
>   Compiling dasd-ipl.o
>   Compiling virtio-ccw.o
>   Compiling clp.o
>   Compiling pci.o
>   Compiling virtio-pci.o
>   Compiling secure-ipl.o
>   Linking s390-ccw.elf
>   Stripping s390-ccw.elf into s390-ccw.img
> 
> So it seems to be working. How do you usually invoke the build?

That's interesting... On both real hardware and my laptop with a 
cross-compiler, I get this complaint (because $SRC_PATH must be null):

eric:s390-ccw$ make
/bin/sh: line 1: /../../scripts/git-submodule.sh: No such file or directory
make: *** [Makefile:138: git-submodule-update] Error 127

I usually compile the top-level directory, and the rest of QEMU itself 
compiles fine. But it doesn't descend into pc-bios/s390-ccw/ (which 
makes sense; pc-bios/meson.build doesn't tell it to).

> 
>> Fearing the worst, I started converting to use meson directly (which
>> is probably a noble goal anyway). I still don't have a workable image,
>> as inheriting the common meson cc/ld flags exposes a bunch of other
>> problems. Will keep poking, but I'd like to know if there's an
>> easier/better option here?
> 
> I suspect the easiest way would be to move the rom specific cross
> compiler detection into a configure script within pc-bios. Paolo wdyt?
> 
> 
>>
>> Thanks,
>> Eric
> 


