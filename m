Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AFFC02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 18:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tb1XZ-00016E-6U; Thu, 23 Jan 2025 13:02:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tb1XX-00015m-BJ
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 13:02:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tb1XV-0005Wo-4u
 for qemu-devel@nongnu.org; Thu, 23 Jan 2025 13:02:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737655367;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=098urcCR1yI3MyJil/Y5HSyq4BlLio0gc+xgCwif+PE=;
 b=darSQ0dnO8H1+8wfloMoCFkrW9jZoy5uCoUp4189Ngwwh7Yehxlnyn0gAwIQ1t3dZY8kin
 0UtngQi7CLuDLyvTueUURKi07Z0Zpmv71O1juHTeENRMRLIHMs1M0AJ9CE4X0j6AZq9tBB
 wF96jCnPI97Tw19STTmFFywCXnGMySk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-TFojJjh-Mu2bCxwE47MAVw-1; Thu, 23 Jan 2025 13:02:45 -0500
X-MC-Unique: TFojJjh-Mu2bCxwE47MAVw-1
X-Mimecast-MFC-AGG-ID: TFojJjh-Mu2bCxwE47MAVw
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab547c18515so137867966b.2
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2025 10:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737655364; x=1738260164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=098urcCR1yI3MyJil/Y5HSyq4BlLio0gc+xgCwif+PE=;
 b=WwNUSsjFUi0JaTGp7kDMm1MQBKExg+Kxr0VAVN9KOOAVia38VisRFIPvVvc2XU2F45
 VUdKl1P/Dzu2MTv1BxZpbErQxT4QDKxdHIWBIgdnHNyly7+nXXw88Nk/nvxh7GoFF4P5
 pV/RB0bEjMCT9vsHB6whTM4muQNeLrTTjviJxIyZe050s3sSSlGqC5UCjVdAk3xe17h1
 n8an+DqEn/ZFUil+Z2GqPkSysrPsaNxKrThuetWZYg8Qrmc0Uv8VdemjmT0zf9mfVdEI
 L6SLvApYcWIOZN3ZJp3Ap81eiS/rVMbe2/EnPt1EOS6p8kerIQNde6abJ6RrxkwspaHk
 ZuzA==
X-Gm-Message-State: AOJu0YwhFVqByEoGXADsw5YPXeLUMoEz4Bm3998RwI3SnkvJSrHt9TUH
 8ajDBp5sAgwOkJqgJuqUd2cb9p2dzA8D3qXNyn7jZumP5yBW3W/FiUHT/WCgs46svWp8PbbPRnG
 BzwGqCKtJzwq7oIet5dzfDp428oZKmDmehEgeEUl8JfePOwiHO/Ed
X-Gm-Gg: ASbGnctRNbLD6sibB4Qn0qPSygHI8ygKT9SryHixIvYLqGexybAl/O29xsOQ09P6kEk
 1+ZWOOEQjsRfFg+l5WZsJOlUOrKhTJ52BcjCxRXAD9nQYshU/9RWaKUhszq46qn0D4pSYWGNyaA
 W69GCIzRtKhVXRv7KUuEB1VXUFpH5t+2DQZWHYPkD2NwGH9DJhcJQCS2X7Dl4vw2V0LduNkbzPk
 lmfnkeEXi/+r25fRfhAyEtjWZ6TzRWdLgxfPc/UDmnXYVcIphXUi5Y9FJN8dC7Bt9zU32ny+QQZ
 Rn84OGJl+B0TcZRB+lPb4ht3I3ezx1CsIwoHNuGrLQ==
X-Received: by 2002:a17:907:94d6:b0:ab3:47c8:d3c6 with SMTP id
 a640c23a62f3a-ab38b0b7f2dmr2301843766b.11.1737655364610; 
 Thu, 23 Jan 2025 10:02:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFrlAc6mEjFG5Pq657QTxQH4GrlJvCXhuSWS7iDMrvVRkoMK1AvG1Dnq3iiWFiewBSwe2Sh0Q==
X-Received: by 2002:a17:907:94d6:b0:ab3:47c8:d3c6 with SMTP id
 a640c23a62f3a-ab38b0b7f2dmr2301838966b.11.1737655364127; 
 Thu, 23 Jan 2025 10:02:44 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384fcec76sm1093030266b.184.2025.01.23.10.02.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jan 2025 10:02:43 -0800 (PST)
Message-ID: <4f3cd6cc-2eba-4bd8-a133-b9b540452cab@redhat.com>
Date: Thu, 23 Jan 2025 19:02:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] intel_iommu: Reset vIOMMU after all the rest of
 devices
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Cedric Le Goater <clegoate@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <20240117091559.144730-1-peterx@redhat.com>
 <79e908f3-3f93-4245-9e5e-25b8a1026322@redhat.com> <Z5KDC4RiimTBmb-g@x1n>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <Z5KDC4RiimTBmb-g@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,


On 1/23/25 6:57 PM, Peter Xu wrote:
> On Thu, Jan 23, 2025 at 10:16:23AM +0100, Eric Auger wrote:
>> I haven't seen any follow-up on this series. Is anyone still looking at
>> this issue? Peter gave some guidance about the way to rework the reset
>> chain. Is it still up to date?
> I didn't continue looking at this issue since that time (and also stopped
> working on vIOMMU stuff).  No plan to continue from my side..  I suppose
> nobody else has either, or I should have got some email like this. :)
>
> It may not be uptodate indeed, so may worth rechecking its validity.
>
> Thanks,
>
Than you for the confirmation

Eric


