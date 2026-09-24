Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 238F6C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:48:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9hvb-0007ux-Ol; Thu, 24 Sep 2026 07:47:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x9hva-0007ug-PR
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 07:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1x9hvY-00026D-P3
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 07:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790250467;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFEpJJW2Ygnswic7m+wgOQUXXnuzXBT68x93F9YM8Dk=;
 b=B6K8t+yQ7g2niudN5RrvhZli/DUy03kyS1hs4Jf4dXyRYpgpWchZ8+KOdICX2KiZzsyc/Z
 n9NYqEOxOhS9gY4HxlLK3zTAeVj4D/nYMIloOqu1DgRBjNK+/JJNHIExJD9UIw6oqLyqbc
 mHCazG/JuWW9KsBGTctAO0AIcYl62n0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-fMxcZ5EQOc-5I9aftxtqPg-1; Thu, 24 Sep 2026 07:47:46 -0400
X-MC-Unique: fMxcZ5EQOc-5I9aftxtqPg-1
X-Mimecast-MFC-AGG-ID: fMxcZ5EQOc-5I9aftxtqPg_1790250465
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-487038bc9b8so1076801f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:47:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790250465; x=1790855265;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:reply-to:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFEpJJW2Ygnswic7m+wgOQUXXnuzXBT68x93F9YM8Dk=;
 b=KW0c6dejeV38tNYNRvFPmDxIOIMji7qcOpNRoLHQXXG791XzU+5+UGfC8d/HM+mHbG
 pd41+2nYf4QviZC7Z9kz4dpOFS7EoBJhKGOP80HYJkWNx8G0qBacpNnNDZlPVgM0/Eh8
 /DPOX3JweoeWNIiVdNoLtwIFGJa37lKApaoRWwRovH2PhBJ/Q2flhDwhEJdXH4/EJjPd
 w2a0SJzL+aM0VRacRSGbLqcBRY0cyD09mYzpMQkeKAkKRjCEsoENNLuc+nMyFblhgnpn
 sMLpP6EWrgStwSA3zDNedoZhQWyidwzJDBuUeDnwESpwcH1tGJgDIOsoYgNb7r7cc/Bf
 VdnA==
X-Gm-Message-State: AFuF++m4lqEO741YDh4dKmeSJMPswYxVylRe7F7Db/LTY8yhyyMgHvln
 QZwMYIuSCnE+yvlMyngLMqHMoFLv6A7wlg09EDA82o9C4qWbyGAl5ub9OEfMqylGRe1VUaMazdz
 M4HTpQVCZ447NJgV9zPMwQPPMc7aKbI1zdqtn9PrfQApmZkCVqQqg9z5y
X-Gm-Gg: AYBFou3xUVworcYIsBk+4a/Zcu2/WiJ9XqrUKIrjTEQ/pW7b2ZzA22Zq/igUhByXgdJ
 litXjpBd1d7kCT7T5zyQUqBiZQXXTk94a221MPApESnLCd4Eq3H8GwVlaFm2Z9sq597aVODrHMA
 YkB5N+PqDthcHr4otP0ljFSeLVGf3sBk5WEqzoy63x71yv3W7NbgQ23Vjhhj/xufPtMvfTtXw4t
 MGIRartsSXzsO+YKBjpHWigoFXvJc4Cmu9EMyr3P+j+6/uhZskzbl046CuTIwaBPPb40LLGxEtI
 a2g0Y+I815v3AYx53I+3mEQ6ec2GkmASCbAvWXYeya8bLnG8pKXmIbPOoJ+bZRYP3pI9kQCwh23
 hvBUnm1HYc9yByqpIgS/iRQs8KiyBTSSC8kIWL9rVWS5MmPho
X-Received: by 2002:a05:6000:4012:b0:487:930:8acc with SMTP id
 ffacd0b85a97d-488717168c1mr3343501f8f.16.1790250464703; 
 Thu, 24 Sep 2026 04:47:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4012:b0:487:930:8acc with SMTP id
 ffacd0b85a97d-488717168c1mr3343461f8f.16.1790250464334; 
 Thu, 24 Sep 2026 04:47:44 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877c379sm13964440f8f.29.2026.09.24.04.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2026 04:47:43 -0700 (PDT)
Message-ID: <b32547b3-c6ac-4887-8a10-59ee84b28938@redhat.com>
Date: Thu, 24 Sep 2026 13:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 08/25] target/arm/kvm: handle writeback for special
 ID register fields
Content-Language: en-US
To: Khushit Shah <khushit.shah@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "maz@kernel.org" <maz@kernel.org>,
 "oliver.upton@linux.dev" <oliver.upton@linux.dev>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "abologna@redhat.com" <abologna@redhat.com>,
 "jdenemar@redhat.com" <jdenemar@redhat.com>,
 "gshan@redhat.com" <gshan@redhat.com>,
 "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "sebott@redhat.com" <sebott@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "yangjinqian1@huawei.com" <yangjinqian1@huawei.com>,
 Shaju Abraham <shaju.abraham@nutanix.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 "ping@khushitshah.com" <ping@khushitshah.com>,
 Sandesh Patel <sandesh.patel@nutanix.com>
References: <20260921123249.1708067-1-khushit.shah@nutanix.com>
 <20260921123249.1708067-9-khushit.shah@nutanix.com>
 <aabcb61b-8341-423f-b113-e7ab2b34c2ac@redhat.com>
 <C220B122-8B4A-43DF-A665-AF1B9DCE3734@nutanix.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <C220B122-8B4A-43DF-A665-AF1B9DCE3734@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/24/26 12:21 PM, Khushit Shah wrote:
>
>> On 24 Sep 2026, at 3:27 PM, Eric Auger <eric.auger@redhat.com> wrote:
>>
>> v9 has changed the way new field values are stored. writable field props
>> and non writable field props could have different setters. A non
>> writable field setter just needs to check the new value is the same as
>> the current host value. No need to record the new value in the hashtable
>> for further commitment.
> How will that work? as based on certain vCPU init options, non-writable fields will change… right?
I meant the new value does not need to be written into KVM because it
must be equal to the current value. But maybe I missed your point

Eric
>
> Warm Regards,
> Khushit


