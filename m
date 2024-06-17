Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16DDDC27C77
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 05:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ4Xl-0001YF-I5; Mon, 17 Jun 2024 01:04:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ4Xf-0001XR-Dg
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 01:04:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sJ4Xd-0005hc-RJ
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 01:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718600668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x9L2t/kjJRJFDwfoABlhEgtNhymMjBaczzclHeSy//g=;
 b=PWCEDBL+owYaolutsnmNxS6PnU7y8+Sn0u5SA+WT3sO3iTu6/0NLaY5jYf9g1Skushosm2
 cgmJ/5vIDtLKucqqyYA1sqwdOj5thk0PHNDt6U2MgxLsQ2bm72GbgDzq4ibQMCgwMLAxJO
 caOBX0HJO8a/vvlufx2CW5W0kY+ld3w=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-192-uW8N91-wPZmTs_7zzezamw-1; Mon, 17 Jun 2024 01:04:24 -0400
X-MC-Unique: uW8N91-wPZmTs_7zzezamw-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6b05b8663ccso42468726d6.3
 for <qemu-devel@nongnu.org>; Sun, 16 Jun 2024 22:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718600664; x=1719205464;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x9L2t/kjJRJFDwfoABlhEgtNhymMjBaczzclHeSy//g=;
 b=FdgrT/AH2DoMsb/uWwEp+jqRGDs+IbV2yEBD2sFfKtcAiFqB6QAkJCkUAAAmObuYri
 yYj1lwuZX7WABEDAv7YCZUcHENg2+WuRt8IvVWuk8iPMg+WUi8J6FSYqGi0d3o/JgP7J
 ezwORfaLpsJsDmM82yl7O7X+IuJPbyAwRwFlCPyL2NZ/iDApczl1Whi6NPEISgL53Lmc
 75hOTah5l4OU9n2BPAjjcQhwDoKNccjjmOpyZnD/bXGMtsa7HvcVPQepeOGEIvKNuF00
 G21gGgHovR8OrHAyxUbIqgcQ3UP3NpS62hjT3mkXKEIb6fhQv3kgL+a7MjZ4OA8uiIYN
 FXkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX38OaYLmYK/Q+WOT9EtAYt77LNAhyAefqC3vopi/a5XdgeB3lOrrKTQYQJk//WyARGH9L2V4qiMy9ewimhQ6TG1beieQQ=
X-Gm-Message-State: AOJu0YwjpGPyIqw45IRKSZxlryGK4gZSglkL/2GqPpPDB1JCQcPVB7MD
 yI+zrufy1ZF+WumrsTEZeb2wqiPLJJaUukzPgAfAn1MToM2zlW6kmtrdiTsbTW0CwXxQj1U73dw
 zLrg2bN/Fv9+UxuemI6gyQQ96k0/93LeHC9V9pY/trXRnI0/GzSOS
X-Received: by 2002:a0c:f810:0:b0:6b2:b0b4:aea9 with SMTP id
 6a1803df08f44-6b2b0b4bd7emr85627766d6.56.1718600664046; 
 Sun, 16 Jun 2024 22:04:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxFrR8vZIP9PA0mKrkmznd8Bvki8eD/zNPoHNNOAydsTurMQgtwlc1UtIvwuJGaUZhldcgzA==
X-Received: by 2002:a0c:f810:0:b0:6b2:b0b4:aea9 with SMTP id
 6a1803df08f44-6b2b0b4bd7emr85627656d6.56.1718600663748; 
 Sun, 16 Jun 2024 22:04:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6b2a5eb498bsm51585166d6.76.2024.06.16.22.04.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Jun 2024 22:04:23 -0700 (PDT)
Message-ID: <f03d4ce2-be6e-4b0d-b2a1-aad9b205b267@redhat.com>
Date: Mon, 17 Jun 2024 07:04:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/16] vfio: QOMify VFIOContainer
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240612130122.813935-1-clg@redhat.com>
 <SJ0PR11MB6744DE0A0E679C54CC4A24AD92CD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <SJ0PR11MB6744DE0A0E679C54CC4A24AD92CD2@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/17/24 3:30 AM, Duan, Zhenzhong wrote:
> Hi Cédric,
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: [PATCH v1 00/16] vfio: QOMify VFIOContainer
>>
>> Hello,
>>
>> The series starts with simple changes (patch 1-4). Two of which were
>> initialy sent by Joao in a series adding VFIO migration support with
>> vIOMMU [1].
>>
>> The changes following prepare VFIOContainer for QOMification, switch
>> the container models to QOM when ready and add some final cleanups.
> 
> Except comment on patch 11 and 15,
> Others LGTM, so for other patches,

yes. I will send a v2 soonish. It is on vfio-9.1
  
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>


Thanks,

C.


> 
> Thanks
> Zhenzhong


