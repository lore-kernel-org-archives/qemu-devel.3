Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A45BDC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 14:29:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmaSn-0002qf-JP; Tue, 19 Mar 2024 10:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmaSH-0002ib-Or
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:28:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rmaSB-00070k-8x
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 10:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710858499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GXiEIsPIhd2olxloerMt/dhJlmpVcyMYYQmt95ald/c=;
 b=OlESdUs0RZj4Ste4MAlZjzncQ3WZrtCaJ7///N0BgcQ+S8syzpQ4RIPiepZkunr+OJ72iN
 iZHlhJXq9O1zM9ZHcViICt8lIHb60WtlxaAZm9N+OJ6ORXzP1V1JIEcw79lFybwAMKduOd
 a6W5SKQVqgY16E66fskvB+PcwrCRSRs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-2CSjRlhyPaaS7j_AEqe3WQ-1; Tue, 19 Mar 2024 10:28:15 -0400
X-MC-Unique: 2CSjRlhyPaaS7j_AEqe3WQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33ecf15c037so3247856f8f.3
 for <qemu-devel@nongnu.org>; Tue, 19 Mar 2024 07:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710858494; x=1711463294;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GXiEIsPIhd2olxloerMt/dhJlmpVcyMYYQmt95ald/c=;
 b=koARrtFwDEckZuPMireeRkdJ0oNAGzmqgB6w7coWPekzdNDnTXVq7Q/Bzv1y+v0j1o
 SRcXYl7uoFDJ32XZuu/qc9B4VMPO1OpLQN0AKl9q3lyhl3HSeZMPzcatwUV2QuU6D06E
 qsBlkaM1cf2GWDYOpwmLzBr6a7Z7B4C0w7XZ41KV9fatRnW+Hpx5P0gKsNe/U02Ydx3W
 Kcu/NnDc4dEjAlwI9AZn8D/X2N0OGjb9nKAtnEtsbdP7nCKBIOS4udBDX4zhBjkc484k
 tfHi2eEV0m5+SbVtaZ9mXdrxGnNG+kn6bH9UwG7nFu3t8LZPPxDkkEF0MwLLhT1KTLeB
 J+cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQRyhmUwJECL7Lo8INH6Hytl6YuzMhqwzEF+bCvZQfWLUOIVCfz7MRIMJFYJnx/XKeXPYG0qktyJmFCOG+YxJesTVyU80=
X-Gm-Message-State: AOJu0YyOMbyLOb+JouUUTJegvHjP3HXXs0SVbjVEVtAR6MlLlldlfygf
 IcZhbAm9x//0cRUaNdfPcPZ4utz/fZaobaFhPjmGHQcibxBwCmxZeQShcm5cxX+UtGUXrApiY+8
 VHotNVXlZ3/XvRZ9xpDmLmytmEgGlGzf8v6H6PdQk/ER8vbn/8kK0
X-Received: by 2002:a5d:510d:0:b0:33e:beca:65ee with SMTP id
 s13-20020a5d510d000000b0033ebeca65eemr9921840wrt.2.1710858494664; 
 Tue, 19 Mar 2024 07:28:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyNOt70nvssVYnhCZRl/NfRDMQMCla+xX7uWXyowjIGHBAeQnj/R2A67+mwpv8+fEcejDn8g==
X-Received: by 2002:a5d:510d:0:b0:33e:beca:65ee with SMTP id
 s13-20020a5d510d000000b0033ebeca65eemr9921821wrt.2.1710858494328; 
 Tue, 19 Mar 2024 07:28:14 -0700 (PDT)
Received: from [192.168.0.9] (ip-109-43-177-50.web.vodafone.de.
 [109.43.177.50]) by smtp.gmail.com with ESMTPSA id
 az23-20020adfe197000000b0033e9d9f891csm5784598wrb.58.2024.03.19.07.28.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 07:28:14 -0700 (PDT)
Message-ID: <3e0a5ecf-fe53-4bfe-9c93-7a7fca0fb157@redhat.com>
Date: Tue, 19 Mar 2024 15:28:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Request for Support: QEMU IPv6 Port Forwarding Issue
Content-Language: en-US
To: "Srinivasu Kandukuri (MS/ECP2-ETAS-VOS)"
 <Srinivasu.Kandukuri@in.bosch.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <AS2PR10MB6711590909DD220D9B735920C92C2@AS2PR10MB6711.EURPRD10.PROD.OUTLOOK.COM>
From: Thomas Huth <thuth@redhat.com>
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <AS2PR10MB6711590909DD220D9B735920C92C2@AS2PR10MB6711.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On 19/03/2024 06.53, Srinivasu Kandukuri (MS/ECP2-ETAS-VOS) wrote:
> Dear QEMU Support Team,
> 
> We are currently encountering difficulties in utilizing QEMU for starting a 
> virtual machine image on Windows with IPv6 networking, specifically related 
> to port forwarding. We are using QEMU emulator version 7.1.93 
> (v7.2.0-rc3-11946-gb68e69cdcc-dirty).
> 
> Our objective is to establish IPv6 network connectivity within the virtual 
> machine and forward ports to allow external access. However, we are 
> encountering errors when attempting to configure the port forwarding mechanism.
> 
> Here is the command we are using:
> 
> *qemu-system-x86_64: -netdev 
> user,id=net1,ipv6=on,ipv6-net=fe80::5054:ff:fecd:585a/64,hostfwd=tcp::2210-[fe80::5054:ff:fecd:585a]:22*
> 
> However, upon executing this command, we encounter the following error:
> 
> *Invalid host forwarding rule 'tcp::2210-[fe80::5054:ff:fecd:585a]:22' (Bad 
> guest address)*
> 
> We understand that the format for specifying host forwarding rules follows 
> the pattern:
> 
> *protocol:[listen_address]:listen_port-[dest_address]:dest_port*
> 
> We believe that we are following this pattern correctly, but still, we are 
> encountering errors.

  Hi!

Looking at the code:

  https://gitlab.com/qemu-project/qemu/-/blob/v8.2.0/net/slirp.c#L824

it seems like QEMU is only using inet_aton() here, which means IPv4 only, 
sorry, but this likely needs some additional changes first to support IPv6 
addresses here.

  Thomas


> Our primary concern is whether QEMU supports port forwarding for IPv6 
> networking. If it does, we kindly request your assistance in resolving this 
> issue and providing guidance on the correct configuration for achieving our 
> objective.
> 
> Could you please advise us on the proper usage of port forwarding with IPv6 
> networking in QEMU? Any insights, suggestions, or instructions you can 
> provide would be greatly appreciated.
> 
> Thank you very much for your attention to this matter. We look forward to 
> your prompt response and assistance.
> 
> Mit freundlichen Grüßen / Best regards
> 
> *Kandukuri Srinivasu*
> 
> (MS/ECP2-ETAS-VOS)
> Robert Bosch GmbH | Postfach 10 60 50 | 70049 Stuttgart | GERMANY | 
> www.bosch.com
> Tel. +918061444397 | Mobile +91-88845-33393 | Fax +91 422 663-4104 | 
> Srinivasu.Kandukuri@in.bosch.com <mailto:Srinivasu.Kandukuri@in.bosch.com>
> 
> Registered Office: Stuttgart, Registration Court: Amtsgericht Stuttgart, HRB 
> 14000;
> Chairman of the Supervisory Board: Prof. Dr. Stefan Asenkerschbaumer;
> Managing Directors: Dr. Stefan Hartung, Dr. Christian Fischer, Dr. Markus 
> Forschner,
> Stefan Grosch, Dr. Markus Heyn, Dr. Frank Meyer, Dr. Tanja Rückert


