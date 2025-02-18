Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30411C021AD
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:42:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQfr-0001ti-Ng; Tue, 18 Feb 2025 11:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQfo-0001tD-Vb
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:42:17 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkQfn-0002om-2l
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:42:16 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-38f3913569fso1804561f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739896933; x=1740501733; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Z8+ybWDre7nd0+PDD6b2fm22qauX/CFtJhqL9jdZCkM=;
 b=FH5LTxhN6YfoSbakPWALXvtddZx9MgthES2bThvprtJI9qxQ3JGn40YqxzLh+E+XB8
 886W1nVUuoNrjCLA0QiRyRxY8PW2MMnECVXle4xJsQXK+X750K35CawzEL3N3PDHiWcH
 9ZxGW/N50UxwPBxJI0nXLjAbd0ZM2tMEjubMy0Y0NNWXnJEr8IwR2bfEoyIvLkfyctMT
 3oFDrJRaKMkSX0WS46sbH519FtAL9jchW0bMQJI4H6mea8ZTmyrxe1vkxaRi/jXAuSDu
 OTmcOfLKzO6REUVv0B/L8sleesq4M2PY5wY7WHQHt/BN+cidXEYXGCIcmKgDItzawRVV
 jbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739896933; x=1740501733;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Z8+ybWDre7nd0+PDD6b2fm22qauX/CFtJhqL9jdZCkM=;
 b=bUzi8mKjXhBOTInn46zryu/dA0/SBjYfdJTamOD6Z780TQ5W4jI1wK1YnZx1spBnNg
 YfUdVbIUojh0ND5+KPa1C4dDhrSV5rscJVObBC9d5Dp1xLCXVg7UkV3UHTbXF0ECAvb1
 FnL+JFTpl6vHl7NM7Wxyw4Qdz0EC3VQulvGCX+I4WOAW2rfhQxKNOid1PW5xMLgevaXO
 mkxXplGcHHcYlU7yTnPypoR4WIRMgYI0qcrAIwS8upwntvPe/+Iia0j35BWqtqdEMaTc
 NXydyyBeg3VZ4vS8jlTkWPo43ZrZy2ri3BUJo0H0f0B/o4owxPsJS2gmjtwyNbwP5tuf
 PZeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnMkE+W+V9/Ah7Wex+ReK+YeWc07pwPb6M/JZLOB7i89buXSkUHHxrhD/jrTSG6OwjG3aO9tnTxH4/@nongnu.org
X-Gm-Message-State: AOJu0YyZPkT57ogeH1PJtuo1eMgrOXdY3PslaK5hStNDQmljWr9jfBpC
 6PKsjILP76JAnIVsKXXRk8A28PM+ElNUEhDKz6qyWYVTtKpQWFKX1+V6+rphzQU=
X-Gm-Gg: ASbGncuCxFy56BmWYqlyXOEa1bqqI4MsmZCNiM403pnh+uEessE/Eb2Rs81GxHiQz9k
 BrxOI15ABB3iprxg90NdlrCGyxUKDLpkQdLw/RPskpxPXrJznQrcHlk3ecu78qBstgeppX83uhs
 a2gkIFOrSp4kXLDTPWnkqvTyqhif4TWtYHxS345+xBvaGD0BvAknWfVmK1LSIb8K31U8n6aJ2t2
 4vfjkKoRU2p50SXhM3uuQUHNMNC4Yv3hFE6NAHgYJsmvDEsc+8CrF9Q2+6RsVT/Pxe5dMptydXJ
 v1laUkKKqVM5/DDaplDu60hko8AovpHy9HiqpEjwvf/E+LBb6pUWMgn72Tg=
X-Google-Smtp-Source: AGHT+IFMuM1DnIx/kxMIyU1kMQSwNSKBs0rj2+4UOm+9MPuzitTsRohjKiyMRAXSsVRusY9U5RboPA==
X-Received: by 2002:a05:6000:144f:b0:38f:4ca6:5fc6 with SMTP id
 ffacd0b85a97d-38f57d17c1amr502095f8f.14.1739896933159; 
 Tue, 18 Feb 2025 08:42:13 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4395a1aa7e8sm189118715e9.26.2025.02.18.08.42.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 08:42:12 -0800 (PST)
Message-ID: <887b8dba-2a23-4e14-8388-729cbbccfd6e@linaro.org>
Date: Tue, 18 Feb 2025 17:42:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU community call agenda items for 18/2/25
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, Brian Cain <bcain@quicinc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org,
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com, iggy@theiggy.com,
 Warner Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Max Chou <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, mimu@linux.vnet.ibm.com,
 "Ho, Nelson" <nelson.ho@windriver.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Wei Wang <wei.w.wang@intel.com>,
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 zwu.kernel@gmail.com
References: <87jz9sq23d.fsf@draig.linaro.org> <87o6yzjlni.fsf@draig.linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87o6yzjlni.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 18/2/25 16:52, Alex Bennée wrote:
> Alex Bennée <alex.bennee@linaro.org> writes:
> 
>> Hi,
>>
>> The KVM/QEMU community call is at:
>>
>> https://meet.jit.si/kvmcallmeeting
>> @
>> 18/02/2025 14:00 UTC
>>
>> Paolo is going to give another rust update along with an overview of
>> how a rust backend goes together.
> 
> You can view/download the video from:
> https://fileserver.linaro.org/s/zQzSmd92ecaT5dN

My notes and few questions for Paolo:

- w.r.t. endianness API, this form seems more natural to my
   C background:

     let hval: address_space_memory.load::<LE16>(hwaddr);

- w.r.t. VMState I understand we'll have machines with a mix of C
   and Rust device model implementations, so we'll have to stick to
   the C migration serialization, and can't take benefit of Rust one.

- Can the Fifo implementation in rust/hw/char/pl011/src/device.rs
   be extracted as "qemu/fifo32.h"?

- Can we remove native_endian() from rust/qemu-api/src/memory.rs,
   as we are trying to get rid of DEVICE_NATIVE_ENDIAN?

- About { embedded / heap allocated } QOM objects: In C developers
   don't want to give away the embedded model, as it offers free
   type checks (while heap-alloc must use runtime checks). IIUC with
   Rust it is the opposite, you mentioned is simpler to get build time
   checks with the heap-alloc version, is that right? (I didn't took
   particular notes about it). I'm interested because for declarative
   dynamic machines modelling, it is simpler to use the heap to allocate
   the objects, and I'd like to promote that more.

- I noticed trace event calls are commented, what is the plan?

Regards,

Phil.

