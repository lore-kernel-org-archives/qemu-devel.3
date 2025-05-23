Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5208C3DA6D
	for <qemu-devel@archiver.kernel.org>; Fri, 23 May 2025 09:53:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIP5Q-0005tn-QA; Fri, 23 May 2025 05:53:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIP5P-0005tZ-4D
 for qemu-devel@nongnu.org; Fri, 23 May 2025 05:53:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1uIP5M-0007u7-I4
 for qemu-devel@nongnu.org; Fri, 23 May 2025 05:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747993982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2ZZ3dhvN/+WGpdgY1lYen+PucTLOpHBm/uT7GrHHWF8=;
 b=Hvv5+UfcvjfsHVgU5Tsqe49WUJg6SGeXUXhhyPrthJCVOB8Jl8CiqxB7h0vsyDt9H2liil
 JQO8BI7e5ON6ZfECpLsTNgQCGtU+da+p6nL1siKTX/QFw1ce/+1SQ7iykqHViJ+HT/qr7c
 SE1XbQWvQmeO/2CAv1pIPSjY47V1v0E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-ovA5cridOcevssUY0d_rbw-1; Fri, 23 May 2025 05:53:01 -0400
X-MC-Unique: ovA5cridOcevssUY0d_rbw-1
X-Mimecast-MFC-AGG-ID: ovA5cridOcevssUY0d_rbw_1747993980
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a3703c1fe7so2733356f8f.1
 for <qemu-devel@nongnu.org>; Fri, 23 May 2025 02:53:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747993980; x=1748598780;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2ZZ3dhvN/+WGpdgY1lYen+PucTLOpHBm/uT7GrHHWF8=;
 b=L4ZoJ8SS3z1jL0xBeSgQQbJC7aWqhSC32c9prLPBKzyzfOxqaoRr3+YItkwc1oz9Xv
 +GmBcvCb6aP1jnA0YRdpPznOvw9K2a8xtAJET6zYOTxqEGLijc6ELx2IxIfRTrGqkAWc
 EV3/fvhDHmcZZ6R7ja+morWB+JZ3OFFaigVrd5G+19SOo0yx4kJ0KE0zL6IxkBgBSgrX
 Zm8xE5rJH1VdZP7bzPzPMTlXDtzGPVpz3PLIdYUcEJX8KidCV/fp4jgwyK2sxyRENrEu
 WkmqjMSC1rhPusbfMStaWeWS/qZn4QVcqXq4nCNYwxDdpH577zR7Z34S8brhQ5q5i94K
 SeXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLGSQv8EFQrFpnHAClhlAeVf7jWqtwYfSMOOyd7z6FwNw7qMbEbFl/gau4x7yELVIyrQI0z8EPP3IJ@nongnu.org
X-Gm-Message-State: AOJu0Yz9p9aRH4sooeRei2XIhrjUfWqD9bZuNYG1Rd4GrIFULACjj+Su
 8aCHaPLI/bCH9iwjAq3oirfN7tHXmQvdI0HAbX8j1OA1/e5UI5KdKtyC7jWwejeimtSubghXVfV
 sqkZWCT3lcTUW6p1LR8ZkcOn6KvP9eE3BUUdYn9/8RVkphjNdsW0/le1j
X-Gm-Gg: ASbGncsquLmok09S0/5oRxfFCPTtDaD/47HEDVjBdYi2iHTNMD1VNTyjxopBqX+WPoe
 lPO073E0zJ1GaKE9tNNGBIiXiLNfs/pbAhNRlLT7RAbCUhs/gosWE5Ad799bKf133u078YbXDEU
 uvXFIvu8r858tXk9w1YOLzgdGsrg25SbbsvgxR6vOBtAsftiqKzNmqbSRzmndNLnf6bZ/K0gstq
 N6XtQh4PHEoXA5/GHr79Intl19qT05LPqhFtzZ5w2DniG2Dv+HT6qby7Fx3LesCAPX9mBCIHlWl
 w4FqFZg6d9eUpfDQt1E=
X-Received: by 2002:a05:6000:2407:b0:3a1:f564:cd9d with SMTP id
 ffacd0b85a97d-3a3600da1edmr25051859f8f.36.1747993980337; 
 Fri, 23 May 2025 02:53:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3o6EWPCQizb6UwGDKZJSOttgrYeFGiG/2sJyO0+ct5emAb9ZPuaEsUZkDdcT7jS/e5vRkjw==
X-Received: by 2002:a05:6000:2407:b0:3a1:f564:cd9d with SMTP id
 ffacd0b85a97d-3a3600da1edmr25051832f8f.36.1747993979943; 
 Fri, 23 May 2025 02:52:59 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:247a:1010::f39? ([2a0d:3344:247a:1010::f39])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37b0bbd1fsm11578695f8f.100.2025.05.23.02.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 May 2025 02:52:59 -0700 (PDT)
Message-ID: <4fb8d841-653c-4d76-b7f6-06b5a676f768@redhat.com>
Date: Fri, 23 May 2025 11:52:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/16] virtio-pci: implement support for extended
 features.
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <cover.1747825544.git.pabeni@redhat.com>
 <b91bba9115031af5c8b66eca737296ea5889dbec.1747825544.git.pabeni@redhat.com>
 <2739771c-cfc7-43df-af68-5445cd714ff2@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2739771c-cfc7-43df-af68-5445cd714ff2@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.275,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/23/25 9:23 AM, Akihiko Odaki wrote:
>> diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
>> index 0fa8fe4955..7815ef2d9b 100644
>> --- a/hw/virtio/virtio-pci.c
>> +++ b/hw/virtio/virtio-pci.c
>> @@ -123,7 +123,8 @@ static const VMStateDescription vmstate_virtio_pci_modern_state_sub = {
>>       .fields = (const VMStateField[]) {
>>           VMSTATE_UINT32(dfselect, VirtIOPCIProxy),
>>           VMSTATE_UINT32(gfselect, VirtIOPCIProxy),
>> -        VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy, 2),
>> +        VMSTATE_UINT32_ARRAY(guest_features, VirtIOPCIProxy,
>> +                             VIRTIO_FEATURES_WORDS),
> 
> Modifying existing fields breaks migration across versions. Please refer 
> to docs/devel/migration/main.rst for details.

Thanks for the pointer! I missed a lot of context. I guess I need some
trickery similar to the "virtio/64bit_features"/"virtio/128bit_features"
VMstate description.

/P


