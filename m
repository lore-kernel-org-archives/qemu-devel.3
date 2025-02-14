Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37DBC021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 11:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1titTx-0007A1-3h; Fri, 14 Feb 2025 06:03:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1titTv-00079m-P3
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 06:03:39 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomitamoeko@gmail.com>)
 id 1titTu-0006oY-8M
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 06:03:39 -0500
Received: by mail-pl1-x644.google.com with SMTP id
 d9443c01a7336-220bfdfb3f4so39245235ad.2
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 03:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739531016; x=1740135816; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NqbdYFoBt8oeHTnPGHDpmggaUCavRYcVRDCzKVS1730=;
 b=a7WsMHpf00/PYrtSSRnEy9sexmmd2sH4MIyFPrPkYYCeJcfQmPVGcext7f+qMoBp6M
 H0+PwaqWZDJehvDk43JylCjfF8CJHqwud1VSoKB22XSIKwrEQgBQe3hB2IhBfl7Lmacr
 88zrHFBPepsjkb8SF3M/G+ZSQhaDXYttqMellYwRCTe75g4yt255ukkWDrx8R04T8S/D
 x46TJYXPhfes1u/CyUtj/rSRxTxGyKwm+Ad2HKqXqvqxVwDGwY4GAE3cr8Q077EgiLhG
 uMGiE2prtRGeDr+ByaLUDsBnqpLIjSza99s1VH/8j5h3TEjktxOdT9G1t3AbkOvTn5fd
 Tkqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739531016; x=1740135816;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NqbdYFoBt8oeHTnPGHDpmggaUCavRYcVRDCzKVS1730=;
 b=UtC9IYcmyxtU7kOPcP5CMNlAo3KYNK+yNqde4Hu9qEaDccCotUzRN8pX/T1Y7IdRA1
 uY5FrW4ndbhENa4fG/G7ooynVuhYqsR2lGg0IIgm7D3ec4gKnbCLmKtR2Cn83rp7k60i
 HNLY3o5JG/JPpXRH2K8/sFvXbhz/IGNP1gPrDy4B+1xPGrSVBJ5LWuNjXC7ln37S+zy+
 AAoPEhG/+unhJgo3JWmvMzgUkSRPjzp/Z+UAipWi4f0Y4tSGQs7P4pdBHEPfBlpjR+c0
 elMNJ2X37+TC2FfewZnUND8nuIVYelXMGBzn1nXM8vI6wWtvhzf1G1KAj1EBiF2D2zjn
 mDNA==
X-Gm-Message-State: AOJu0Yz/JNYFwITtPrdoGXeV0AinRzq27UEaFDJMxTLD1I1w65jXLERW
 IyIhlWpDTXqDfETpEsMVr9lnYpYHK1UHLLIt1OID0b1o9k6R7UJbLsC8arqepw==
X-Gm-Gg: ASbGncunXZM6aSGXrss45vYkdwZsllwB1WaNne43hao+twzIILlHfPxezFBVXR+dTl2
 q/OXN5Hn+wmv8b8u9HvyKEIpyTQIrV9ijBbFU2/zzgncn5Ftu05yJT4HAwYLLjYI8vjOyN1KebD
 m+sT5INP+JjtK3ZUy/6EGOFgwXyAm2LbcuIiRO2L1kb2NdVm0Wn3uAAVFUudAdFYNZjlPo/T/nW
 XjUn889DshxHuEk+/DtYo7vQHeLpKGPgZaZ2mtpJiVDpwU0JZaTXUaZMyYGBY2h/wnIqUkwvKT9
 vX3c5RScERnI9RQwi5vMEg==
X-Google-Smtp-Source: AGHT+IGUPx1ZWqqtHq7gYWNoHrcuBYwfW9yta6DLttmL/bsiQQ7eeHnaHsYWxSBHXAVpjV7uhDt99g==
X-Received: by 2002:a17:903:2ac6:b0:216:725c:a12c with SMTP id
 d9443c01a7336-220bbab3e4emr157320575ad.9.1739531016241; 
 Fri, 14 Feb 2025 03:03:36 -0800 (PST)
Received: from [192.168.0.113] ([116.232.67.252])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5349019sm26775705ad.36.2025.02.14.03.03.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Feb 2025 03:03:35 -0800 (PST)
Message-ID: <6038be5f-4e25-48e4-bec4-666be4f5ed36@gmail.com>
Date: Fri, 14 Feb 2025 19:03:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio: Add property documentation
To: =?UTF-8?Q?Corvin_K=C3=B6hne?= <corvin.koehne@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Tony Krowiak <akrowiak@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Eric Auger <eric.auger@redhat.com>
References: <20250213135050.1426258-1-clg@redhat.com>
 <20250213144513.32b3241f.alex.williamson@redhat.com>
 <ef8108aa73c693cc54c08c81a14201138b14172f.camel@gmail.com>
Content-Language: en-US
From: Tomita Moeko <tomitamoeko@gmail.com>
In-Reply-To: <ef8108aa73c693cc54c08c81a14201138b14172f.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=tomitamoeko@gmail.com; helo=mail-pl1-x644.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



On 2/14/25 17:31, Corvin Köhne wrote:
> On Thu, 2025-02-13 at 14:45 -0700, Alex Williamson wrote:
>> On Thu, 13 Feb 2025 14:50:50 +0100
>> Cédric Le Goater <clg@redhat.com> wrote:
>>> +    /*
>>> +     * IGD
>>> +     */
>>> +
>>> +    object_class_property_set_description(klass, /* 2.7 */
>>> +                                          "x-igd-opregion",
>>> +                                          "Add IGD OpRegion support for
>>> (headless system)");
>>
>> [Cc Tomita and Corvin have more recent understanding of IGD options]
>>
>> Not necessarily for headless systems, unless others have better
>> suggestions, maybe just "Expose host IGD OpRegion table to guest".
>>
> 
> Sounds good. Note that it's required for the Intel GOP (EFI driver) and the
> Windows driver. So, it's mandatory for non headless systems.

"Expose host IGD OpRegion to guest" sounds more accurate I think.
OpRegion is not a table, it contains Video BIOS Table (VBT) for display
output port info.

>>> +    object_class_property_set_description(klass, /* 2.7 (See c4c45e943e51)
>>> */
>>> +                                          "x-igd-gms",
>>> +                                          "Add Intel graphics legacy mode
>>> device assignment support. "
>>> +                                          "Assign 00:02.0 from the host to
>>> 00:02.0 in the VM");
>>
>> Not really.  Tomita added a useful comment and commit log in
>> 37f05a59e869.  Perhaps:
>>
>> "Override DVMT Pre-Allocated value for IGD stolen memory. (32MiB units)"

"Override IGD data stolen memory size. (32MiB units)" might be better.

> Nit: This sets the Graphics Mode Select value of the GMCH Graphics Control
> register. While we currently only support values in the range of 0x00 - 0x40, I
> don't see a reason to not support 0xF0 - 0xFE which uses 4 MiB increments.

I skipped the 4MiB values before for keeping the conditions simple and
these 32 MiB values should cover most cases. We can consider supporting
4MiB values.

