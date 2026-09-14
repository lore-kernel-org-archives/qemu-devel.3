Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C25EC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 16:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x69JA-00063R-HM; Mon, 14 Sep 2026 12:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x69J8-00062E-HD
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:13:26 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x69J6-0007V3-5F
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 12:13:26 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED0heh135640
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Vj5DqFSOs1dHBiu4zIcfcCgdwhjphJX0PVG3trqTnSo=; b=OqcMZD4qdZqchw+b
 7XvIe3O0oYabVnkb5ob6A25ifYDUrYRTx1ZMJb+lPLKlodi53JkGCOhc9gbhdHx1
 1jldY+X1iEHpj1KucXLZiHP1krg1oKv47pTIcOqoKdf5+d8TQR4+pOu3K0ZGgjp0
 wQVg3cA2uDD+bJJupycTqMDzb4Qsw7pzujKItBYPtKRCsYtNvt9PQ306ckEGtswk
 USQ1dj8WqHUP1JGktbgREkW81Ycf8X/OymAZWi2NDJ23TPM8WM2CP00Crdv23Rhx
 xcyrxjLJEQSRJenhWic8rKV9z52J38jHm9109ANs62CttP4BjNhWhJ5+kIDXCCq7
 C6IK9Q==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpeuq9h0e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 16:13:21 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7ec6685adabso4530238a34.0
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789402400; x=1790007200; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Vj5DqFSOs1dHBiu4zIcfcCgdwhjphJX0PVG3trqTnSo=;
 b=Wq8OX+aGLHeV/x4NDzUBFi8IRX4OMMTo9qzVEzmQ9N1CRS3L2yHg+jdYuKS1+TWwoF
 8kLsvf8waEDmb3mI6v4hniCw4yjpFngj/Nuu/teKdhUVAqx7sC2oyFsP0YxOVBb8JTWh
 9fiTMaLnu76FAni1SDsZ0zGAVbU7FBwCBp4MslOEB/RKPFEPQXQdIR2E8pkspQKk17nq
 6AP3SlF3gJfwMC02G54inkaxsMa+i5Z3yUXG+ORIP/fux3hlAngNq6E0P5Rcmw100wPQ
 hpIQD6tin6H/AlYkFzAH3yWalcGLipQukFn/viDdFqcPSxgfHQ0pwhSwEWrLwxfW7lYC
 6n7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789402400; x=1790007200;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Vj5DqFSOs1dHBiu4zIcfcCgdwhjphJX0PVG3trqTnSo=;
 b=krXgCL9P7z7x+zguRCFXnm9qRFPlp9ai8rc8Jh9tHY9e5N1Ls5xgqAfd7hu6vXJOsw
 qyRvVJz7yUNKeWjcX5Vp/kRQbQnaSYsSN/VqACEGRBvWxzgN1TdWwJ1kSLOxHr8x3riJ
 Ak34cZyIefyTX9G9vyPYjcgu7fvUkoer+Y37N7NdiSwrEcQsS8kCaip//uVCqq7BJB/I
 6XdWUq1Klr81gUc05dbdYleRospjd8E3BDyNpvx3oWX3XQlCHJ9CyRTyltKSNwBa9YcP
 VWzxqgYXitFRVC60LHCHqMumn0zFTFZzAv/yhUAfhgFylguN4VdDCA6oET/gHbHhNGm8
 3dmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz48o0nf5psLpr3XRCaUINrHssUscTzsIJDDoE4ZKWAxg9ySP/q+5itsT9gAVh9cE969QDYBIDB2a9y@nongnu.org
X-Gm-Message-State: AFuF++nNA8Ibsz31PCKwT0j0XQIVd/Z+9dzl4aISQpF3k32V4KneQYLF
 FbwVOK8vFRox3DY7w8q1I5DJxz77D+p4xV1eB1xUN7IdZXFDDfbj23y/lzZeZo+22vwJO9hM2xR
 4z5oyvHOki1wcBioSqb6bnUAaOuxJvga50Mr477t6rgQxEhdmOGo1SqCerQ==
X-Gm-Gg: AYBFou0MtUfUtWPz21Exk+e9kvt6ZX7bEkC8G4p2p/eLvjNagNyNi8ej3mfBK4ocfkX
 G+Jt2Y0Hojv98KZzBfI88mY+3pKltXeCa0DBIeKPngr9Y+wT7Qit3C6QYOLuEngPpvg3pt9DWgv
 +1xiD2zBCf5pKD7lQA6TCxGqrOMF5z4mZy5pMHd1oxfvd6jniB+LKlhOPAZjAxUwAVI6u17Q6TP
 F5m0ZOBlgVKIJlV8r0MlFaNvUxG33RyO+C3Ya/lZt0wRT4UiI/HZMcq4nTF7DUYffDFZxwGExTF
 j7InxyeMcZevrSbS6emx0mH2H9cL92h77vZeQKC6mYC4OzqW2m4RG18xnG6A+y7U7+FrTo4ztEm
 JV1U+6pj/TPsCR+w1O4H4LXIqLBe+k4lpvBfbkf8PZa/Jdt5oTp/ohFKDZjah4FL3Q7s3
X-Received: by 2002:a05:6820:16a3:b0:6b0:5bd1:4722 with SMTP id
 006d021491bc7-6c53f74b405mr1644753eaf.13.1789402400161; 
 Mon, 14 Sep 2026 09:13:20 -0700 (PDT)
X-Received: by 2002:a05:6820:16a3:b0:6b0:5bd1:4722 with SMTP id
 006d021491bc7-6c53f74b405mr1644715eaf.13.1789402399645; 
 Mon, 14 Sep 2026 09:13:19 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b759d0sm27401958c88.7.2026.09.14.09.13.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 09:13:18 -0700 (PDT)
Message-ID: <5cc8dd29-9093-4082-b8e5-32823f21c71d@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 09:13:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 102/105] configure: remove cross_cc and gdb detection logic
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-devel <qemu-devel@nongnu.org>,
 Aniket Sahu <asahu1x@linux.ibm.com>,
 Jared Rossi <jrossi@linux.ibm.com>, Zhuoying Cai <zycai@linux.ibm.com>,
 Joshua Daley <jdaley@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260904124604.2207440-1-alex.bennee@linaro.org>
 <20260904124604.2207440-103-alex.bennee@linaro.org>
 <dab85c9c-4718-48d1-a343-c2e6b5f8e24f@linux.ibm.com>
 <87a4pn8yra.fsf@draig.linaro.org>
 <CABgObfYEN8Qme6zXGYJpEeHTiFegjOm=Ym-3vU9LE1Z-Wsot3g@mail.gmail.com>
 <231c5426-b1b9-4465-b62d-a61dcb41c041@oss.qualcomm.com>
 <CABgObfZnyHenuVJ6maVs+jMNQCJeYhtcnXtXOqN1G3NcbvDt7g@mail.gmail.com>
 <aqfX2414cAMCcI18@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aqfX2414cAMCcI18@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIzMSBTYWx0ZWRfX9WWvC+Ycj4q8
 YRtrqCi/Bg8Y0sx4xyhgkWYCshHRpjFH0pdpgR7ey6VHQIY2wnP0YxEDRsGG7pdyQfBffY3MC3t
 5Uc6M6EibEioc/N93vkKacwf76CFi1wcX2HrFZ8i+XH7sTfjmIFciiJXd9rw76JYJHWPqh7dUI1
 k7XiJx861etbBI3X1speipmtMW2ZkNNM3cGvRvEQsamf24yDvaGRTvVPxhkm010PwzTocLzugKL
 Zl/a0l4n4FSTcP454ePm3LxYI4cQQ2CwiTVokAbvQ9DdoUIPDGyrh2zXy3KYEFtauV7yyct+BW/
 LnyWrz1/48mLEij7glsdv8IdQCA7OK2bljO3wuYqLjcWoQ7Dsic8pCjQLtUVatv4W5uG8XkVVUp
 EHgvnOX9sZ6Kl0LrYDrU1cWVOv2DwauRLxF7FqsNia6JY2+GLGELo2bnVWZR63T0ohWLGu0CrV5
 m5Lcc7VrOvEkeHpLNtA==
X-Authority-Analysis: v=2.4 cv=TrFzFzXh c=1 sm=1 tr=0 ts=6aa81d21 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=KKAkSRfTAAAA:8 a=mDV3o1hIAAAA:8 a=EUspDBNiAAAA:8 a=pvaXX8DnYRzaiYFQ-tkA:9
 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: LgKDIjKPbEs0jy39mPn22gvJIiv0qTRL
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIzMSBTYWx0ZWRfX517OAQLvOg8u
 D/HHLWqRiCZBSGGz3BcooXm19+AXFJka9aQ9xQ/NvMHjncTzXfP2fxwcp5VCmibKekf1xfCNDrD
 0OWUHc15nEoBmxGbILnWj7KmP219t5o=
X-Proofpoint-GUID: LgKDIjKPbEs0jy39mPn22gvJIiv0qTRL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140231
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

On 9/14/2026 4:17 AM, Daniel P. Berrangé wrote:
> On Mon, Sep 14, 2026 at 11:41:51AM +0200, Paolo Bonzini wrote:
>> Il lun 14 set 2026, 07:54 Pierrick Bouvier <
>> pierrick.bouvier@oss.qualcomm.com> ha scritto:
>>
>>> On 9/13/26 9:57 PM, Paolo Bonzini wrote:
>>>>
>>>>
>>>> Il ven 11 set 2026, 19:49 Alex Bennée <alex.bennee@linaro.org
>>>> <mailto:alex.bennee@linaro.org>> ha scritto:
>>>>
>>>>     Thanks for pointing this out. I hadn't noticed the issue as I guess
>>> we
>>>>     don't build firmware in the CI. That said on my current tree:
>>>>
>>>>       cd /home/alex/lsrc/qemu.git/builds/all/pc-bios/s390-ccw
>>>>       make
>>>>       -Wno-stringop-overflow detected
>>>>       -fno-stack-protector detected
>>>>       -Wno-array-bounds detected
>>>>       -Wno-gnu detected
>>>>       -march=z900 detected
>>>>       Assembling start.o
>>>>       Compiling main.o
>>>>       Compiling bootmap.o
>>>>       Compiling jump2ipl.o
>>>>       Compiling sclp.o
>>>>       Compiling menu.o
>>>>       Compiling netmain.o
>>>>       Compiling virtio.o
>>>>       Compiling virtio-net.o
>>>>       Compiling virtio-scsi.o
>>>>       Compiling virtio-blkdev.o
>>>>       Compiling cio.o
>>>>       Compiling dasd-ipl.o
>>>>       Compiling virtio-ccw.o
>>>>       Compiling clp.o
>>>>       Compiling pci.o
>>>>       Compiling virtio-pci.o
>>>>       Compiling secure-ipl.o
>>>>       Linking s390-ccw.elf
>>>>       Stripping s390-ccw.elf into s390-ccw.img
>>>>
>>>>     So it seems to be working. How do you usually invoke the build?
>>>>
>>>>      > Fearing the worst, I started converting to use meson directly
>>> (which
>>>>      > is probably a noble goal anyway). I still don't have a workable
>>>>     image,
>>>>      > as inheriting the common meson cc/ld flags exposes a bunch of
>>> other
>>>>      > problems. Will keep poking, but I'd like to know if there's an
>>>>      > easier/better option here?
>>>>
>>>>     I suspect the easiest way would be to move the rom specific cross
>>>>     compiler detection into a configure script within pc-bios. Paolo
>>> wdyt?
>>>>
>>>>
>>>> I would prefer to revert this and load the config file from meson
>>> instead.
>>>>
>>>> Paolo
>>>>
>>>
>>> I would be happy to see only the related part reverted if possible, and
>>> not all the patch. That said, no strong opinion, just a preference to
>>> avoid seeing people start depending on this config file for other
>>> things, instead of doing things properly in meson.
>>>
>>
>> This is documented as a task for configure, so I don't think it's a problem
>> not to do it in meson. In fact creating containers is not done by meson
>> (it's done by make) so there is no real reason to do it outside configure.
> 
> Are you referring to the tests/docker/Makefile.include targets ?
> 
> Pierrick's series here directly invokes docker.py from meson instead
> of the targets from tests/docker/Makefile.
>

There might be some confusion with what the series introduced. To make
it clear, it does not touch, nor use tests/docker/Makefile.include.

Each tests/tcg/arch declares which container it depends on, and we have
tests/tcg/meson.build that automatically builds it if needed for tests.
Reverting that will not be very easy to be honest, as it's a core part
of the new logic.
 > IMHO it would be nice to replace tests/docker/Makefile.include with
> a meson.build too. Yes, that would make it rely on a configured
> build tree, but IMHO that's an acceptable tradeoff to get more
> stuff into meson natively.
> 

That's easy, and would allow us to get rid of
tests/docker/Makefile.include completely, by adding matching targets
make container-image-debian-*. Also, we can have a top target
'container-images'. With this, people can build them with ninja or make.

As Daniel mentioned, the trade off is to run configure first, and I feel
it's quite acceptable. What do you think Paolo?

>>
>> Having firmware have its own configure script is also bad, since you end up
>> having code duplication.
>>
>> Overall, I don't see the big issue in reverting this patch.
> 
> NB, if this is reverted then we'll need to pull back in the fix I
> dropped:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2026-09/msg01624.html
> 
> With regards,
> Daniel


