Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5358DC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 17:46:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmdXp-0002lr-0e; Tue, 19 Mar 2024 13:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rmdXf-0002lD-O1
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:46:31 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rmdXc-0004IK-Vn
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 13:46:27 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 073564E602E;
 Tue, 19 Mar 2024 18:45:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id 0SnmmCsufJSK; Tue, 19 Mar 2024 18:45:18 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id AC0564E602D; Tue, 19 Mar 2024 18:45:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id A8E047456B4;
 Tue, 19 Mar 2024 18:45:18 +0100 (CET)
Date: Tue, 19 Mar 2024 18:45:18 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Thomas Huth <thuth@redhat.com>
cc: "Srinivasu Kandukuri (MS/ECP2-ETAS-VOS)"
 <Srinivasu.Kandukuri@in.bosch.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 Samuel Thibault <samuel.thibault@ens-lyon.org>, 
 =?ISO-8859-15?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: Request for Support: QEMU IPv6 Port Forwarding Issue
In-Reply-To: <3e0a5ecf-fe53-4bfe-9c93-7a7fca0fb157@redhat.com>
Message-ID: <594ca1ae-d910-25c6-72cc-ffccda0da79c@eik.bme.hu>
References: <AS2PR10MB6711590909DD220D9B735920C92C2@AS2PR10MB6711.EURPRD10.PROD.OUTLOOK.COM>
 <3e0a5ecf-fe53-4bfe-9c93-7a7fca0fb157@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1445307105-1710870318=:70493"
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1445307105-1710870318=:70493
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Tue, 19 Mar 2024, Thomas Huth wrote:
> On 19/03/2024 06.53, Srinivasu Kandukuri (MS/ECP2-ETAS-VOS) wrote:
>> Dear QEMU Support Team,
>> 
>> We are currently encountering difficulties in utilizing QEMU for starting a 
>> virtual machine image on Windows with IPv6 networking, specifically related 
>> to port forwarding. We are using QEMU emulator version 7.1.93 
>> (v7.2.0-rc3-11946-gb68e69cdcc-dirty).
>> 
>> Our objective is to establish IPv6 network connectivity within the virtual 
>> machine and forward ports to allow external access. However, we are 
>> encountering errors when attempting to configure the port forwarding 
>> mechanism.
>> 
>> Here is the command we are using:
>> 
>> *qemu-system-x86_64: -netdev 
>> user,id=net1,ipv6=on,ipv6-net=fe80::5054:ff:fecd:585a/64,hostfwd=tcp::2210-[fe80::5054:ff:fecd:585a]:22*
>> 
>> However, upon executing this command, we encounter the following error:
>> 
>> *Invalid host forwarding rule 'tcp::2210-[fe80::5054:ff:fecd:585a]:22' (Bad 
>> guest address)*
>> 
>> We understand that the format for specifying host forwarding rules follows 
>> the pattern:
>> 
>> *protocol:[listen_address]:listen_port-[dest_address]:dest_port*
>> 
>> We believe that we are following this pattern correctly, but still, we are 
>> encountering errors.
>
> Hi!
>
> Looking at the code:
>
> https://gitlab.com/qemu-project/qemu/-/blob/v8.2.0/net/slirp.c#L824
>
> it seems like QEMU is only using inet_aton() here, which means IPv4 only, 
> sorry, but this likely needs some additional changes first to support IPv6 
> addresses here.

Other than that, the [] in the help mean optional components so you don't 
need to put that in the command. But if it does not handle IPv6 addresses 
then maybe not only that's the problem. However since dest_address is 
optional and does not need to be specified you could try to leave that 
[fe80::5054:ff:fecd:585a] out completely then the rule should applie to 
all guests but if you only have one guest then it does not matter.

Regards,
BALATON Zoltan

> Thomas
>
>
>> Our primary concern is whether QEMU supports port forwarding for IPv6 
>> networking. If it does, we kindly request your assistance in resolving this 
>> issue and providing guidance on the correct configuration for achieving our 
>> objective.
>> 
>> Could you please advise us on the proper usage of port forwarding with IPv6 
>> networking in QEMU? Any insights, suggestions, or instructions you can 
>> provide would be greatly appreciated.
>> 
>> Thank you very much for your attention to this matter. We look forward to 
>> your prompt response and assistance.
>> 
>> Mit freundlichen Grüßen / Best regards
>> 
>> *Kandukuri Srinivasu*
>> 
>> (MS/ECP2-ETAS-VOS)
>> Robert Bosch GmbH | Postfach 10 60 50 | 70049 Stuttgart | GERMANY | 
>> www.bosch.com
>> Tel. +918061444397 | Mobile +91-88845-33393 | Fax +91 422 663-4104 | 
>> Srinivasu.Kandukuri@in.bosch.com <mailto:Srinivasu.Kandukuri@in.bosch.com>
>> 
>> Registered Office: Stuttgart, Registration Court: Amtsgericht Stuttgart, 
>> HRB 14000;
>> Chairman of the Supervisory Board: Prof. Dr. Stefan Asenkerschbaumer;
>> Managing Directors: Dr. Stefan Hartung, Dr. Christian Fischer, Dr. Markus 
>> Forschner,
>> Stefan Grosch, Dr. Markus Heyn, Dr. Frank Meyer, Dr. Tanja Rückert
>
>
>
--3866299591-1445307105-1710870318=:70493--

