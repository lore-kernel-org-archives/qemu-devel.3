Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FAEC982D0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 18:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7GrI-00042E-Tc; Thu, 17 Sep 2026 14:29:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7GrG-00040b-US
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:29:19 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7GrE-0001PP-WD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 14:29:18 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68HH5ecl2170945
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 18:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SMhCdj5ffXgN+BB/PpF1S3H7rPU+LkwXuu9uuZtKL+0=; b=gR8dq473DZOrKTYb
 i6UktLlyFORyitXFrhXdLiBHIoExrvr9FZXS1quJ1M6HvxDf8AwV2e/5+2I3F5zl
 QDFjIpRjEuNicaWpvRyU3hJMXRQIujyG2UtkEAURCWFeo7UEWUICP3k5FwiOvyiR
 63vTOHLdd8FVBWq2ze513uH4J4LNUK68JlOs41fiRk3nXyiNk5fr/XbR7vOjvk4v
 IFe70gw+wRmdYElqGHMN7K41pOLwht1PS2Zacp5iVhX+6dBy0XY1JOsqR5Kru1mt
 JtDGDgpYfkZEQ0Urz+wXbESLSgVttTNs8C+A3GemoChrOWu08X+wFNy3q/lKXjEF
 cbXLiw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4grk97rseg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 18:29:15 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cc435388657so1693357a12.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 11:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789669753; x=1790274553; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SMhCdj5ffXgN+BB/PpF1S3H7rPU+LkwXuu9uuZtKL+0=;
 b=Dz5Ri84LN6af3S9LPTlaIZeX1xRZM1p5ziUjguXqPCxTXpE0xCzQ0VDk6e8tlpfMsP
 +yoFWOa5Q8Ld80j2Am4xswkvL8KBDWG7HSjo7ijVts/WERYrfCUiKHM9KVXOe2M+okaN
 rdbgYjpe0uTsurdpPBTqzvCsX5EgkYNr74SVkh/iRCAf/bbR/X6S/yq3x8FoDUH2el7R
 zkadJkgyK/iN2+v3zHqdmTLKAwhXmJ7QdygGb7VY+/AZDzpT/D6XmI96odCHaVtK7hC4
 7SQhn03vPwsvltHmcJthPMZllR1uNnF1h+9ow4bqAHtTHaherIM7AXP4hkutNFNU4aak
 CBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789669753; x=1790274553;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SMhCdj5ffXgN+BB/PpF1S3H7rPU+LkwXuu9uuZtKL+0=;
 b=XphSKIxZQ8f6U955uSyysIiYySg2LWwIHFWDpAEx8FYB/EhCnF+k+5c4W0V9aXggY7
 nOgfCsT0KzrFRnUBn7l2izOXil4D40cu68PgkyvdznYWexZEin5NX9HLTJbTvXP2TzxH
 6HwKbDgv8UvqZke8VV+MBKnG3MsItVBFkICJAt6dBHeOGlnyGg7IH49OzRWuMUs8QJBr
 AP8jUqrveRm2rASspAeXORu5h1UNHxwgNsmaUAxdvOqpj4uVUX3H+kv2nRKfSCstwJRr
 fm0p2fpda054KcYdFewtqqaltDUo6DqabOYKyjM5lkXfolmCCUcFmZYo2rjNRlorUNRO
 k2cw==
X-Gm-Message-State: AFuF++kdSEbMEaT4kmZYYOQ8BKsNhEhgokStg65UYGfroS06ZqXLfj2e
 eo4L3HDNyjGcuYvda3ZIlBfuGasoQyOS/qsSpIhKe42PGgtqN2ld9kHHMqyTuKjv0Y6ZpFCfN50
 RVVxviLLD+I/4819XaawliKHNcr9wZDhOj15LZ14T+UO6q70QWd7AkzAvLQ==
X-Gm-Gg: AYBFou3SwtgflyRf+jghXahmGbyqbNfp+Uz4JNF4ABkCQw3zLTB2F1B7nGnW2R8ZSpq
 iQMMWHzOQSOmnNsp91a+L2An8P0diU1WN7j+xJw/itlKmOWkt9GkeE19XhI1sHQtlQIghCGY+EQ
 UjkbfYFHuQjl9GbrGY30VJYi/QWrXPoK7gA6oQ5KvCjaKmeKm5zNDxHgiOYRrOUkVoQPI9tJZKw
 HOebtO5DbKgaR8apd5KSq/OMY/8XdYs59JxWw1rqxeJoPOm3MGqNA1L8sGY5Q3SXx0je0d+LbGX
 e5On9JW9Y2Sj+SOT+vqDIRTtYFb13RN7dKYVMMyTfjwtDI6VP2pfmqWFCslgAI2nfUOALmllq3+
 bOPkI5NIUe5ioMnvYJtkZ7/62/c1D/udW0pYA6ZcKtHrnlqA9PUuASiinKeVSR+ZyOqz6
X-Received: by 2002:a05:6a21:1f83:b0:3dd:85a9:55a5 with SMTP id
 adf61e73a8af0-3dd85a9610fmr2708337637.30.1789669752950; 
 Thu, 17 Sep 2026 11:29:12 -0700 (PDT)
X-Received: by 2002:a05:6a21:1f83:b0:3dd:85a9:55a5 with SMTP id
 adf61e73a8af0-3dd85a9610fmr2708272637.30.1789669752373; 
 Thu, 17 Sep 2026 11:29:12 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395bf6e8esm15460277c88.0.2026.09.17.11.29.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2026 11:29:11 -0700 (PDT)
Message-ID: <4a3ad35f-930a-42b3-ad3a-606b689884b4@oss.qualcomm.com>
Date: Thu, 17 Sep 2026 11:29:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/17] testing: various docker clean-ups post meson tcg
 conversion (pre-PR)
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Helge Deller <deller@gmx.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Matthew Rosato
 <mjrosato@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Warner Losh <imp@bsdimp.com>,
 John Snow <jsnow@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, Brad Smith <brad@comstyle.com>,
 Kyle Evans <kevans@freebsd.org>
References: <20260917165602.3405537-1-alex.bennee@linaro.org>
 <c0c5cf55-b4ff-495b-babd-3a75fd991127@oss.qualcomm.com>
 <87qzir7ovo.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87qzir7ovo.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=LOzz05W9 c=1 sm=1 tr=0 ts=6aac317b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=kCIV5lFW7023qDVEj4cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI2NCBTYWx0ZWRfXxPb1eBlEKY94
 ANx+KSL9fGdBOncJeBEa54xGGEvhzp3CB46sEiynTPGw+JppDU0NKtTDvN6GP66UVPkJ+ela30E
 1r7MNs3CRrAvNMl0EE3gtUT0QcKwxFvwqEtW2L/6fDSxsIVCcjTvkGFeX3pGFUGpap1KARh9Djr
 FW7neDwxySvFIGSi0BCQbuMgMvslGSWK9QYCQHs4mMafKN5VHqNtIu3e1kRkb2rIQmNx2t+p/7p
 RAVdY1q7K6pjxu2hXKeIPRpWJfIYo+NdLLtOB8uipUEzcGvV7BbLlsZh/D4olnxOwk1yMnbUZ9p
 U1gW/57QFADsE2w22/2m4pkeZQGliotf4UoSEmiBe9L6SLaM7j0Pit+7fspOY6QbJdQeE7NgJS7
 AFpUzL2ZI89oqSO+ffQZXhGTQtTNECKZmeFMujpfOWI858PepqlfmqWJzQHpoxiqRKYrBoaz++R
 KY/+oBrZzpkIfit5SvQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI2NCBTYWx0ZWRfX5OhaDoj7cS0l
 4Ok8A1c2wl9H4joAbQyh3wMR33tiVUbkr3h3nT2p1ELb9S8QRdCTe0U7mGEV4V9D2jKdkTIvI7n
 Hzte2ylIsL0QP/Hm+9g0OOe9K6VBJWo=
X-Proofpoint-ORIG-GUID: ivB-pRne39TrG9pd0_t6Rp1b10qKEdgI
X-Proofpoint-GUID: ivB-pRne39TrG9pd0_t6Rp1b10qKEdgI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170264
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/17/2026 10:45 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 9/17/2026 9:55 AM, Alex Bennée wrote:
>>> This cleans up a few bits and pieces although doesn't totally solve
>>> the issue of an apparent stall while meson builds the docker image.
>>> However with these changes there should be no difference between the
>>> meson build and the equivalent "make docker-image-foo" invocation.
>>>
>>> We also finally get rid of the ill-advised magic caching support in
>>> docker.py.
>>>
>>> v5
>>>  - fixup a bunch of rebase damage
>>>  - swap out my ccache fix for Anders
>>>  - rename revert to "configure: ensure it also honours container configuration"
>>>  - use Pierricks solution for avoid too many SKIPs while validating config
>>>
>>
>> It seems that this version removes patch:
>> Revert "tests/tcg/meson.build: implement ./configure -cross-cc-* options"
>>
>> That's fine and correct, but we're missing two things:
>> - cross-cc-cflags and prefix should be passed to config.mak also
>> (similar to the merge for container options). Not strictly needed as I'm
>> not sure anyone needs this "extra" flexibility for roms/vdso, but needed
>> if we want to make sure we don't break anything for anyone.
> 
> The rom builds are outside the main makefile anyway so they just include
> random bits as they want.
> 
>> - scripts/meson_buildoptions.sh update that was missing originally for
>> those meson options.
> 
> We need to do something about it because at various times
> "update-buildoptions" does and doesn't change things. Sometimes there
> are more options than I've been messing with. It is super confusing.
>

Agree, in my personal experience, I never could regenerate it through
Makefile dependencies, even if it's supposed to work.

What we could do is generate it directly from meson_options.txt, instead
of meson introspect. It should be quite easy as meson_options.txt can be
"included" as a python file, and we can provide option() function to
aggregate them.

This way, our only dependency becomes python, which is already a dep
anyway, and not our full venv + meson. We could directly generate this
in configure, without any need to keep the file checked in our tree.
This way, it would always be up to date by design.

I'll let Paolo judge if that's a good idea or if I missed something
important.

>>
>> For the rest, it looks good and ready!
>>
>> Regards,
>> Pierrick
> 

Regards,
Pierrick

