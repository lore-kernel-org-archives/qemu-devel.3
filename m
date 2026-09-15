Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852D6C88E75
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6VkU-0001bN-Us; Tue, 15 Sep 2026 12:11:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Vjo-0001TX-VW
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:10:32 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6Vjl-0005Ue-Ij
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:10:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68FFAnFe4061590
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I0r3BpRpLLg0Dc5mcJddmk6DeMGo+atcTPhNhbdlNQ8=; b=jdFMl/vOI1lmgyQf
 82H00GHlg/VF5my058qEPUTmS3aPf5/Oivn2jtlDVJpLfJR+I/XJGb5mMWP/XHzJ
 p9tYdvhnJszcfg2U1ZG7b/mAgq2JLhDQ5NGrMNlNJpo7k7NRuKgiKzKQ419UesuD
 H8lBLcB76/DejJF1bYNfofIjIUBn4cSDL2Vi8M0iFurZJ+qtWcKz2DXohM1rI7K0
 o6orhW4BJDM7lt+xXv2opmn4tgWGr2DqSGH1kuXTj2olrcV4Pg1jnFnS+0NUtQ6j
 RnHN+HL6MysX3Rxu8mRlQYTgaH8v/9QF7Iy84HPuaQs5qbpNSSa6cxk34beMyoyQ
 vXD2YA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gq38e1vn4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 16:10:23 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39e18af9f48so102319a91.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789488623; x=1790093423; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I0r3BpRpLLg0Dc5mcJddmk6DeMGo+atcTPhNhbdlNQ8=;
 b=HhE5EaggbqjABQUz2MuKsK2+tHsE9hM/o3fiIxKD4KNrQbET5LE2RUKIHER1cyYW88
 oxIDBZPklhAbLzq150PXZRvzAffujG5Vq/LyEhkg1oKaUk3IRkCDMP0NpL8ZJiXAZ9sx
 tRZkKLF14ZN7T1KUzo4yRNYXjxtUbaK/Ntb8Vr3/OAxj3Y+8+2Jc/9aU9yKRElP7AXp5
 R28Ih6WH/9BGN1aqCPfAMz7vCzKASEeW3CjvdSpT5sa0BtkZHlqKzy7PgUni3K2uf15P
 2wyjqm4rgP3Sn9C2/kg34Su/8xoa0eZvJCUBbmQ3sV+aNqqPAb0X7A70SEnaHn+R9tCh
 urJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488623; x=1790093423;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I0r3BpRpLLg0Dc5mcJddmk6DeMGo+atcTPhNhbdlNQ8=;
 b=sO37SzMKNXvyMosXVoirVFtP17F8H/UQQzBRdFSQWOOA8/SuKRPDp0sO0NvZvWunku
 P7EGLiEe4OSloj3VFzeTPyyTa7AOCIkiiVOQslio0ImPVTRAGZAF2U27Hz8cASQhQKhh
 UBI1Nm7oVL7Mx6w6yOTJqKHulf13UkkouHcR1M/Wx5NjVX0M+GfF5gx+NNhPAhEi5FSq
 Z++b0Uj0IFX+YPL+h+MSS9gNEKMwS+i+zog9QqItwWW7IFtMRgkxPhf7aG5j/wFXbWw7
 8S3VdzL9aTdn3G0IwLFiayfrXjT4WQN6mTu5YfVRmMd+LvHhwLuW9D9LsVO5KbJfQhvp
 j3Tw==
X-Gm-Message-State: AFuF++k+Tk9p1tS/k+6h1KKAt/1f9RZzwAYPBj8qagQp/THVjO7NaCPZ
 8CRW0YGTF0WgOqnnPUjwQl54jYKxzDiKKMxTsKk1YXLBWZZ4ElCsblA9vBHRa5LXLoO6+5gMe5o
 O7OLkRPfmhoBsvwMLzi5qRSb6Prvr62E2270Cqp20G4wpAZ9SHLq0iaFlWw==
X-Gm-Gg: AYBFou1IQ5ko4Do8J1cETwrJ72pophFQjs1ZbH24nccGzHLh+VMbMDxhYBpSzlk0lPo
 F4+nhHr9lNsXQJ6A5c27mvQgO7ZQqtUje+UiugpQD7kSeO8s5ErRqsNvJglnjFo3U2csWc+7xHe
 w1f7mBPYZB9um4uGfWnA0ezab+rhK4XQkk8gMKBS8AoAnA1mKBM/C+cCJj6wQmhzMz7xhA2Cqq4
 Qw2+7opPC0jmqoNR/9KjdkpRbQmLX5dEqYEZNBqGWrI5Wa84kf9OxiQSh8eBD9IPUgVEYVlebzX
 18rybMGGKbZoI4ir2OGOcZ2DDL4tQ3IwC8Xal6ziwXwBFf46PHBv/mVEH6qAEP3XmcgUfiO64tt
 pRF0lDVf8f3dlJyTaXJ49Bv3giKd547fZAIr1gCFDfPL1hY/8k65ya7bPXT1xPKLDOvfc
X-Received: by 2002:a17:90b:2d8e:b0:398:cb8f:c308 with SMTP id
 98e67ed59e1d1-39dfdce1f86mr6734870a91.0.1789488622983; 
 Tue, 15 Sep 2026 09:10:22 -0700 (PDT)
X-Received: by 2002:a17:90b:2d8e:b0:398:cb8f:c308 with SMTP id
 98e67ed59e1d1-39dfdce1f86mr6734814a91.0.1789488622409; 
 Tue, 15 Sep 2026 09:10:22 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5a6a182sm341300eec.8.2026.09.15.09.10.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2026 09:10:21 -0700 (PDT)
Message-ID: <0cec32d7-38ff-4c2a-aa93-b590586091f0@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 09:10:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/6] roms/Makefile: add vofrom
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org, Zhuoying Cai <zycai@linux.ibm.com>,
 qemu-ppc@nongnu.org, Eric Farman <farman@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, Matthew Rosato
 <mjrosato@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Jared Rossi <jrossi@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260915004802.5749-1-pierrick.bouvier@oss.qualcomm.com>
 <20260915004802.5749-3-pierrick.bouvier@oss.qualcomm.com>
 <e0e2e072-e43a-cf80-284c-588d2b06cc9b@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e0e2e072-e43a-cf80-284c-588d2b06cc9b@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8QEbHdziQcN7FuUBkOwpe8OPk8_GOe_R
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzNiBTYWx0ZWRfXyg4tP24DVEAq
 kieMK8Z/4nsUQb407A8GHwmG07/Wkjpo4zuEVJ3rUE6V87/6k9jvbmoeqNaENeshJgbGGNu/oWK
 t8ovjE2KFvOCn80dkJ03JD1tfEUEdQ4=
X-Proofpoint-ORIG-GUID: 8QEbHdziQcN7FuUBkOwpe8OPk8_GOe_R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzNiBTYWx0ZWRfX7JuBTLvQ/FeF
 Ap9m3NTVuD0WgDfcfVu3UxR8BonHYc4NnL4oMrGwnYno0gczYC1HDjTG1TN6TosLvWm2rVXEVSF
 Vhlezy97PE1tahrPplr/gBbjQr+xXOKIAtEI6dhpe/UOyXka0wGVZpTY8rEH7jn/XemDTGl3T8Z
 Ji6N8HcqrzHTsNFE4M1d+wDk5qP44SAB4zDTHL4iw7/e2zy2m4nyMUvGOs5L9NUfyvAt+D81c1b
 8enCrVoWLl87cvtFrOdiAH/8rIs9KK264j0xZxvj1ZFS+u4NqTKCGz99EPF1KNGCMoVF7wbrnXj
 nHe/ZIHWp7ok+WH2cvkfTAfhxNUdyHkKm995vTzIZ5I2dKijfurZuxKHq0eb/13VlJcgbIg+D95
 Vgh+JONy6IlRf2LaffO/TDFp1T8ogoo0Z6QPf09n+guaPYftEmbiPssfj+ND/EA7bfaZvMtzXpO
 k/vaQQVqy1tdvGzreOQ==
X-Authority-Analysis: v=2.4 cv=BswIUoX5 c=1 sm=1 tr=0 ts=6aa96def cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=VhGgxYGU6cJ879sss4sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150236
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 9/15/2026 5:51 AM, BALATON Zoltan wrote:
> On Tue, 15 Sep 2026, Pierrick Bouvier wrote:
>> Remove dependency on config.mak and simplify Makefile.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>> roms/Makefile     |  6 ++++++
>> roms/vof/Makefile | 21 ++++++++-------------
>> 2 files changed, 14 insertions(+), 13 deletions(-)
>>
>> diff --git a/roms/Makefile b/roms/Makefile
>> index f15189a5409..84f22943d35 100644
>> --- a/roms/Makefile
>> +++ b/roms/Makefile
>> @@ -63,6 +63,7 @@ default help:
>>     @echo "  pxerom             -- update nic roms (bios only)"
>>     @echo "  efirom             -- update nic roms (bios+efi)"
>>     @echo "  slof               -- update slof.bin"
>> +    @echo "  vofrom             -- update vof.bin"
> 
> Is it a problem to call it just vof similar to slof? The name vofrom
> never appears anywhere else and is a bit confusing.
>

Nothing particular.
This series will be dropped anyway (see comment on v1).

>>     @echo "  skiboot            -- update skiboot.lid"
>>     @echo "  u-boot.e500        -- update u-boot.e500"
>>     @echo "  u-boot.sam460      -- update u-boot.sam460"
>> @@ -136,6 +137,10 @@ slof:
>>     $(MAKE) -C SLOF CROSS=$(powerpc64_cross_prefix) qemu
>>     cp SLOF/boot_rom.bin ../pc-bios/slof.bin
>>
>> +vofrom:
>> +    $(MAKE) -C vof
>> +    cp vof/vof.bin ../pc-bios/vof.bin
>> +
>> u-boot.e500:
>>     $(MAKE) -C u-boot O=build-e500 qemu-ppce500_config
>>     $(MAKE) -C u-boot CROSS_COMPILE=$(powerpc_cross_prefix) \
>> @@ -217,6 +222,7 @@ clean:
>>     $(MAKE) -C edk2/BaseTools clean
>>     rm -rf edk2/Conf/
>> {.cache,BuildEnv.sh,build_rule.txt,target.txt,tools_def.txt}
>>     $(MAKE) -C SLOF clean
>> +    $(MAKE) -C vof clean
>>     rm -rf u-boot/build-e500
>>     $(MAKE) -C u-boot-sam460ex distclean
>>     $(MAKE) -C skiboot clean
>> diff --git a/roms/vof/Makefile b/roms/vof/Makefile
>> index d1eb6ced7ec..d5dbb374356 100644
>> --- a/roms/vof/Makefile
>> +++ b/roms/vof/Makefile
>> @@ -1,27 +1,22 @@
>> -include config.mak
>> -VPATH=$(SRC_DIR)
>> all: vof.bin
>>
>> -NULL :=
>> -SPACE := $(NULL) #
>> -TARGET_PREFIX := $(patsubst %/,%:$(SPACE),$(TARGET_DIR))
>> -
>> -quiet-@ = $(if $(V),,@$(if $1,,printf "%s\n" "$(TARGET_PREFIX)$1" && ))
>> -quiet-command = $(call quiet-@,$2 $@)$1
>> -
>> +CROSS := $(or $(CROSS),powerpc-linux-gnu-)
>> +CC := $(CROSS)gcc
>> +LD := $(CROSS)ld
>> +OBJCOPY := $(CROSS)objcopy
>> EXTRA_CFLAGS += -mcpu=power4
>>
>> %.o: %.S
>> -    $(call quiet-command, $(CC) $(EXTRA_CFLAGS) -c -o $@ $<,Assembling)
>> +    $(CC) $(EXTRA_CFLAGS) -c -o $@ $<
>>
>> %.o: %.c
>> -    $(call quiet-command, $(CC) $(EXTRA_CFLAGS) -c -fno-stack-
>> protector -o $@ $<,Compiling)
>> +    $(CC) $(EXTRA_CFLAGS) -c -fno-stack-protector -o $@ $<
>>
>> vof.elf: entry.o main.o ci.o bootmem.o libc.o
>> -    $(call quiet-command, $(LD) -nostdlib -e_start -T$(SRC_DIR)/
>> vof.lds -EB -o $@ $^,Linking)
>> +    $(LD) -nostdlib -e_start -Tvof.lds -EB -o $@ $^
>>
>> %.bin: %.elf
>> -    $(call quiet-command, $(OBJCOPY) -O binary -j .text -j .data -
>> j .toc -j .got2 $^ $@,Extracting raw object)
>> +    $(OBJCOPY) -O binary -j .text -j .data -j .toc -j .got2 $^ $@
> 
> Why are these losing quiet-command?
> 
> Regards,
> BALATON Zoltan
> 
>>
>> clean:
>>     rm -f *.o vof.bin vof.elf *~
>>


