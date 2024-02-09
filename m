Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54662C4828F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 21:12:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYYAZ-0004cE-Cx; Fri, 09 Feb 2024 16:12:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYYAX-0004c5-Oe
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 16:12:21 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rYYAV-0006fF-QV
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 16:12:21 -0500
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a3c1a6c10bbso21349766b.3
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 13:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707513137; x=1708117937; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=keo/6k/FTj74NcS+Fji2GBFDZ/jA+gzMZe11dnB1ZNU=;
 b=ZDcdvxwNdp2a23HbMo728yX2RjzavhK5vO70Ma+MUDZnthU7/0lmwfz+OzhyuIOlCx
 QqXr+5yJyg8CmaRphR+djRR08L5bVbGGKqjwVnA10v2MLZDA+SdQ7lqs1e+SSKTj4dZR
 UoSWYx8TaZORv7KrBObki1aSbdnusEWvhJM+aXhSonEFBKbHIQMZjjT9CJGnxttIUaJq
 505xtdMmexT/t9vJ34zBXh2RKJdIBtO6BHsLJ3ABKCJ8vCvS7jJjVfUCU7F+jl+ZwSyl
 xnUcYd0j4NRZjkKyrIFezxNN0x4HTOxCnMWtbpXS5zuNb6CNI+rZA4YqGFNAd2COI7yo
 uhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707513137; x=1708117937;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=keo/6k/FTj74NcS+Fji2GBFDZ/jA+gzMZe11dnB1ZNU=;
 b=fRtILQ27RPOTQZz9VMr7LTsPDV+8OVQVfNoYIK6vRsTvP3uwBtWCiNDP7AlQTb7x9L
 BTQRth7n0c4HxPizidXGvYjvsiaHIZEpJpaKDZlEPeOiGQlGBuHludM8GcsijSqsuvwL
 kO9qoJPXfEfABq/A1KT5PHPU4KihsHu9LVf5HE+u2R/ZmdvJSeA33T7X2mffONmJ/HrN
 ugKy1lzNz9haiJy0rMNUwsA1tEdalGfd9dO+Xqc4kEVb8CqBgHR7A23ET9csOQcQUMRL
 HvzDaav/5tLRr/3VS+tss8RIGlzlUHl0RED9hVcwKx4SoOBLAsHo7nsxw61DENX92C//
 XgKQ==
X-Gm-Message-State: AOJu0Yywe2u5g4XLzGFUFiV/4vouLkQ79C7qvVbg8b8tcWVHVRpkfcPG
 lkFOdafRpobIzHse7UdK/Q7a7x4HnXHbjDNKO1+FTusBwzLzvXDE81/sP4CZSopqXQYFjVQ50A7
 T
X-Google-Smtp-Source: AGHT+IEykkQ64n3BOqwoQzIg55+88IbpOJhqHLXRNMxh87lZESXYK2or0roisbcFwLX0l+ZyHDbmiw==
X-Received: by 2002:a17:906:d8b8:b0:a37:e5fd:94ee with SMTP id
 qc24-20020a170906d8b800b00a37e5fd94eemr209319ejb.72.1707513137363; 
 Fri, 09 Feb 2024 13:12:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXLD6GnYvUWuYHvWNL1GbSQNOugL01TaNLohDANbkb6IkmmEA6a4v42AGltiyBqfPEYKNP1K5qZ1THbe0ISLahKYX8c191lKzn98a+iSTqlkmlxUj7F2OCJGGcxIksIqVOCBGMaRu6v53hgODem4AUQdh+dnFV5qSw/XAa2cFcXoG/bJKTOtTvKfiQ2tXgDKab8jlHevdJ4QZtpNt0MQDXKAxhNqNQA2YUCV2XHXc/z4f7rrsYsZ4SbC87qh76XkE60RxtflPDweYHTKb54d1S/9NvyHPROaoL5QS0HboXgsmdQC+9Ep7G4ReBXlk7FvQKaIZ9N80pvO2ZEoawoZZgY5sOgC1S60tt+blwXZbiGZG01hgail17lQ+f3QLgB07OWTljWKNLkOWfpFl6FI/umhp2QHV0qxlMqhkRyQieUz9L9XQl8rpLLhXUTJVCa98128xJs85U1YvGYkRxLZApR/LbUe9mqfLa0/ZzuYqrZGSA9T+hrfXsWF+3iPiJDm7+w2vd7+EI5S8QzhMsZX/qBGJWpLFq4NZBC3DU5NFzZDqHyIuy6GcCf27reBpEMJTIwyBkaD8BXF5WKIJtHSUKGNRbDKMAG3KNTfl4ek/J1gbRbQYJMj4xSyjfTDWwDUzyLPcc1k9kYDg6OQOGdTl2v/1UP+mGc2yi/902usTX1OXrCu/P3FX8TWdQoPO5jyU1uJM4ZuEVNkMmvL7l776Ugwkbdi/xnIBZ6hnFnxXChYOH0eKovgUtffsQ87THE7+q2J5P3HKRCFfTc0vC2pYXuTx6dMKjuW1LFVoEY8r7jVSk1JdcyRaSom8nKul7fXgnSu0u3upgS4rfV+xTpe/nRbMSU8k1ISCUJz7aRV2lxY2i1h2VE+3aKfgtkzJkzhF8Rv3Txfec4VxjtAndGxI+8SAZbwaxer+58Duaf4d8+f39A9JNuyVGZYMiG71uBpIWTli
 wCPhno2+KV/dtArCc8nKQENz+ZWGx7UPHiwWjYD4ae6tmFcGuRuouqsMZXufBuu+By1UpbLpXbxh+05MpeJkgnwzbzpglmd3zAcYLaWsguQACTaHrdX99q6hAu/ljX2ny+QF7RTF2SZuhCGDBaq45JZAyJCoRbY3h8VRiP/H7SRgjWOke7llR88CJFbG1BfEahVDtQxcHzjUoO9Bt2zLy/J6KPDXIgTXoMu7yB2nylhYz7zZYGJGp6ZQcfQQ3A978AHhTGwvFHTpvizIw6jAI/SqQIjXPEofWIUvsfv87jTrhQZjbBSSTLSgdGyPKtAHVMex72g7yRrg==
Received: from [192.168.69.100] ([176.176.147.207])
 by smtp.gmail.com with ESMTPSA id
 s14-20020a17090699ce00b00a3bf0fb69besm851601ejn.113.2024.02.09.13.12.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Feb 2024 13:12:16 -0800 (PST)
Message-ID: <cdf1ec6e-8cc2-408c-81fe-b21808b74f2e@linaro.org>
Date: Fri, 9 Feb 2024 22:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: KVM/QEMU Community Call 6th Feb Agenda Items (minutes)
Content-Language: en-US
To: qemu-devel <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Mark Burton
 <mburton@qti.qualcomm.com>, mdean@redhat.com, felipe@nutanix.com,
 cw@f00f.org, eblake@redhat.com, iggy@theiggy.com, jidong.xiao@gmail.com,
 peter.maydell@linaro.org, stefanha@gmail.com, Warner Losh <imp@bsdimp.com>,
 zwu.kernel@gmail.com, jgg@nvidia.com, cjia@nvidia.com,
 konrad.wilk@oracle.com, wei.w.wang@intel.com,
 Joao Martins <joao.m.martins@oracle.com>, afaerber@suse.de,
 bbauman@redhat.com, eric.auger@redhat.com, jan.kiszka@web.de,
 jjherne@linux.vnet.ibm.com, mimu@linux.vnet.ibm.com, z.huo@139.com,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Chao Peng <chao.p.peng@linux.intel.com>, Brian Cain <bcain@quicinc.com>,
 Luc Michel <luc@lmichel.fr>, Bernhard Beschow <shentey@gmail.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Alessandro Di Federico
 <ale@rev.ng>, Mark Burton <mburton@qti.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 LIU Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Jim Shu <jim.shu@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, Anton Johansson <anjo@rev.ng>,
 Damien Hedde <dhedde@kalrayinc.com>
References: <87mssij1y2.fsf@draig.linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87mssij1y2.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi,

On 2/2/24 16:55, Alex Bennée wrote:
> 
> The KVM/QEMU community call is at:
> 
>    https://meet.jit.si/kvmcallmeeting
>    @
>    6/2/2024 14:00 UTC
> 
> As I'll be away Philippe has volunteered to run the meeting.
> 
> So far we have one agenda item which is to discuss next steps from
> Markus' post about dynamic modelling:
> 
>    Message-ID: <87o7d1i7ky.fsf@pond.sub.org>
>    Date: Wed, 31 Jan 2024 21:14:21 +0100
>    Subject: Dynamic & heterogeneous machines, initial configuration: problems

I took notes on a document but am unable to share it so far,
so I'm sharing the minutes replying here.

Some people complained the call wasn't announced like previous
ones with Juan calendar invite mail, so I built this Cc list from
the old calendar invite recipient list and mixed with the list from:
https://etherpad.opendev.org/p/qemu-emulation-bof%402022-11-29

Unfortunately exporting broke the document indenting, I tried to
adapt it my best.

---< minutes >---

6 Feb 2024 | QEMU community call

Attendees:
- Philippe Mathieu-Daudé
- Zhao Liu
- Markus Armbruster
- Mark Burton
- Anton Johansson
- Cédric Le Goater
- Bernhard Beschow
- Maciej S. Szmigiero
- Manos Pitsidianakis

Notes
- Discussion around https://lore.kernel.org/all/87o7d1i7ky.fsf@pond.sub.org/
- Future of NUMA topology (current options are too limited)
     - should we add more CLI options
     - Move to QOM containers (better for DynMach)
- Ambitious projects, how to share work?
     - We can not go in all directions at once
     - start a new binary to experiment (no backwards compatibility 
problems)
     - Can we work in parallel? Are there serial steps?
     - Can we avoid working on a fork?
     - Should we avoid QMP as DSL to describe machine
- Convert QEMU code base to libraries?
- Is QDev DeviceRealize sufficient? SystemC steps:
     - Construct
     - Config start
     - Config done
     - Before end of elaboration
     - Wire / Connect
     - After end of elaboration
     - Ready to start simulation
     - Reset?
- Next steps?
     - Add new experimental target: Phil
     - Initial startup: Markus
         - Currently QMP available too late for dynamic machine
         - Define clean QEMU init state machine
     - Shared TCG frontends: Anton
     - Create QDev devices from QMP?
         - Clarify QDev states
     - Start QDev2 in-tree to avoid churn with the current QDev API?

Action items
[ ] Template for this document
[ ] Share this document out of Linaro
[ ] Setup a community calendar invite, Cc’ing interested people or 
letting them subscribe
[ ] Next meeting next week!

---< /minutes >---

In order to share tasks I put the "next steps" items on the wiki:
https://wiki.qemu.org/Dynamic_machine_and_heterogeneous_emulation_roadmap
Feel free to add any relevant steps and where you want to help.

Mark Burton asked if Peter Maydell and Paolo Bonzini could be in the
next week call (Tue 13) to discuss about next steps and whether a
in-tree prototype binary could be accepted in mainstream or not.

A such prototype binary has been proposed here:
https://lore.kernel.org/qemu-devel/20240209152945.25727-1-philmd@linaro.org/
Personally I think at this point there are no blocker so we can
discuss on the list as usual, there is no need for someone specific
presence to debate on this (yet) IMHO.

Still we'll have a call next week and discuss the roadmap. An
any other topics the community want to bring.

Regards,

Phil.

