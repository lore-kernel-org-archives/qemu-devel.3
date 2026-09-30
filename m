Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6DBCA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 16:59:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBxdh-00054m-B7; Wed, 30 Sep 2026 12:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBxde-00054H-GZ
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:58:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xBxdc-0004Vx-Pm
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 12:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790787514;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jkOAPaLms21epo+0Hdf30QKDR3Nlwozt4byBCuwM9uc=;
 b=W4qjcy4npsYrpKLApatlPvi5EDdBCdPhmD6rHAKocM9sJ1JOmPUWFk6+dnBVnvINaAxWbn
 r4AznEH7sHokt9TBRUWpE2zsZtY8tAT8wKtW6G3kI6hTFyXUoM+aiqtbbFIcyz29bYeh9+
 AKTsI4jBKVwBdpNxtIU3Ow/1zDERWyI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467--ICIPqiNMziwEs5N9thb0g-1; Wed,
 30 Sep 2026 12:58:30 -0400
X-MC-Unique: -ICIPqiNMziwEs5N9thb0g-1
X-Mimecast-MFC-AGG-ID: -ICIPqiNMziwEs5N9thb0g_1790787509
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B17BD18A5A26; Wed, 30 Sep 2026 16:58:28 +0000 (UTC)
Received: from [100.90.56.12] (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 428E41956045; Wed, 30 Sep 2026 16:58:25 +0000 (UTC)
Message-ID: <d399ab81-771b-44f4-9c7c-df05bf30c6d0@redhat.com>
Date: Wed, 30 Sep 2026 18:58:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] docs/devel: relax policy on AI-generated contributions
To: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260921075251.12831-1-pbonzini@redhat.com>
 <20260921075251.12831-2-pbonzini@redhat.com> <arEvLLYK9A5MKNdE@redhat.com>
 <arP7TDfz7lz699KJ@redhat.com> <87ik3vyp3i.fsf@draig.linaro.org>
 <arT_kefzEhqg8-FB@redhat.com> <arUJxE0F7Q3Cw5sk@redhat.com>
 <arZHWKAgr-GYvoeX@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0j
 UGFvbG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT7CwU0EEwECACMFAlRCcBICGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRB+FRAMzTZpsbceDp9IIN6BIA0Ol7MoB15E
 11kRz/ewzryFY54tQlMnd4xxfH8MTQ/mm9I482YoSwPMdcWFAKnUX6Yo30tbLiNB8hzaHeRj
 jx12K+ptqYbg+cevgOtbLAlL9kNgLLcsGqC2829jBCUTVeMSZDrzS97ole/YEez2qFpPnTV0
 VrRWClWVfYh+JfzpXmgyhbkuwUxNFk421s4Ajp3d8nPPFUGgBG5HOxzkAm7xb1cjAuJ+oi/K
 CHfkuN+fLZl/u3E/fw7vvOESApLU5o0icVXeakfSz0LsygEnekDbxPnE5af/9FEkXJD5EoYG
 SEahaEtgNrR4qsyxyAGYgZlS70vkSSYJ+iT2rrwEiDlo31MzRo6Ba2FfHBSJ7lcYdPT7bbk9
 AO3hlNMhNdUhoQv7M5HsnqZ6unvSHOKmReNaS9egAGdRN0/GPDWr9wroyJ65ZNQsHl9nXBqE
 AukZNr5oJO5vxrYiAuuTSd6UI/xFkjtkzltG3mw5ao2bBpk/V/YuePrJsnPFHG7NhizrxttB
 nTuOSCMo45pfHQ+XYd5K1+Cv/NzZFNWscm5htJ0HznY+oOsZvHTyGz3v91pn51dkRYN0otqr
 bQ4tlFFuVjArBZcapSIe6NV8C4cEiSTOwE0EVEJx7gEIAMeHcVzuv2bp9HlWDp6+RkZe+vtl
 KwAHplb/WH59j2wyG8V6i33+6MlSSJMOFnYUCCL77bucx9uImI5nX24PIlqT+zasVEEVGSRF
 m8dgkcJDB7Tps0IkNrUi4yof3B3shR+vMY3i3Ip0e41zKx0CvlAhMOo6otaHmcxr35sWq1Jk
 tLkbn3wG+fPQCVudJJECvVQ//UAthSSEklA50QtD2sBkmQ14ZryEyTHQ+E42K3j2IUmOLriF
 dNr9NvE1QGmGyIcbw2NIVEBOK/GWxkS5+dmxM2iD4Jdaf2nSn3jlHjEXoPwpMs0KZsgdU0pP
 JQzMUMwmB1wM8JxovFlPYrhNT9MAEQEAAcLBMwQYAQIACQUCVEJx7gIbDAAKCRB+FRAMzTZp
 sadRDqCctLmYICZu4GSnie4lKXl+HqlLanpVMOoFNnWs9oRP47MbE2wv8OaYh5pNR9VVgyhD
 OG0AU7oidG36OeUlrFDTfnPYYSF/mPCxHttosyt8O5kabxnIPv2URuAxDByz+iVbL+RjKaGM
 GDph56ZTswlx75nZVtIukqzLAQ5fa8OALSGum0cFi4ptZUOhDNz1onz61klD6z3MODi0sBZN
 Aj6guB2L/+2ZwElZEeRBERRd/uommlYuToAXfNRdUwrwl9gRMiA0WSyTb190zneRRDfpSK5d
 usXnM/O+kr3Dm+Ui+UioPf6wgbn3T0o6I5BhVhs4h4hWmIW7iNhPjX1iybXfmb1gAFfjtHfL
 xRUr64svXpyfJMScIQtBAm0ihWPltXkyITA92ngCmPdHa6M1hMh4RDX+Jf1fiWubzp1voAg0
 JBrdmNZSQDz0iKmSrx8xkoXYfA3bgtFN8WJH2xgFL28XnqY4M6dLhJwV3z08tPSRqYFm4NMP
 dRsn0/7oymhneL8RthIvjDDQ5ktUjMe8LtHr70OZE/TT88qvEdhiIVUogHdo4qBrk41+gGQh
 b906Dudw5YhTJFU3nC6bbF2nrLlB4C/XSiH76ZvqzV0Z/cAMBo5NF/w=
In-Reply-To: <arZHWKAgr-GYvoeX@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/25/26 12:05, Kevin Wolf wrote:
> What has changed so fundamentally (i.e. not just shifted in numbers)
> since then?

I think what has changed is that people have gained more experience in 
what LLMs can do, which is hard to put in a commit message, and that it 
can do way better than it used to even in areas where the user can drive 
the design.  These areas are the ones where risk of involuntary 
copyright laundering is smallest, because human input is larger. 
Basically they became good at areas that are less risky in terms of 
copyright, and that's more interesting than areas that are less risky in 
terms of consequences (like tests).

We weren't wrong in being conservative, but I do believe the risk 
balance has shifted.  Contributors can be creative while using AI, and 
the possibility of using it for more interesting and creative things 
than "give me a device model" already mitigates the risk.

The fact that some risk exists is clear from Conservancy's idea of 
treating logs like corresponding source, even though I don't think it's 
practical.  I think a different and more practical approach is to steer 
how people use the tool: the AGENTS.md instructions in this series, and 
the requirement that people send well organized patch series, together 
should make the output "more human" and less subject to involunyary 
repetition.

On top of this, we have the arms race of fixing vs. finding 
vulnerabilities, where the fix has limited or no creativity and is way 
below the copyright threshold (this does not mean the fix is correct---I 
still think LLMs lack taste in many ways---but that's the role of the 
maintainer no matter who submits the fix).

>> With this in mind, it is perhaps not that different to accept a little
>> bit of uncertainty in risks of LLM unknowingly copying from training
>> material or 3rd party incompatibly licensed code it happened to find
>> while walking the web ?  The key is that users need to be diligent
>> in their use of the tools, not reckless. Norms for what that means
>> are still be established - the so called "clean room" or license
>> laundering, re-impls of projects are a massively risky activity
>> but are the exception.
> 
> So basically you're saying that it's our interpretation of the DCO that
> was wrong from the beginning, and it shouldn't actually be understood as
> strict/literally as we said it should?

Not entirely.  But we tried to make things black and white, which is 
generally an approximation.  For example we ignored altogether 
incremental improvements, which can be sizeable, for the sake of having 
*a* policy: "check if this function call can be moved earlier, and do it 
if so", small bug fixes, code that can't really be derivative of 
something outside QEMU (e.g. upgrading to a new version of an 
in-development kernel API).

As you replied elsewhere, a patch that adds a new device model of 
several thousand lines need to be handled with great care.  Even if it 
was accepted, one might seriously consider taking the output of the LLM 
and clean-rooming it *by hand*.  A new board that just pulls together 
existing devices, or a new accelerator, is considerably less risky even 
if it's in the same LOC ballpark.

I trust maintainers to understand where the risk lies.  We're still the 
same people that accepted the previous policy and I don't see us going 
berserk on accepting AI contributions.

> Even if people generally agree that that's the case, that should be made
> explicit. With the history of our claim that it's impossible to sign the
> DCO for AI output, we can't just mention in passing that the usual
> requirements like signing the DCO apply as if that is the most natural
> and uncontroversial thing to do, when we ourselves are claiming the
> opposite today.
> 
> I think that's what Paolo tried to address with the paragraph you
> suggested to remove. While its wording isn't perfect, I do think we need
> something like it.

Yes.  The idea that AI-used-for is an attestation of its own, and that 
the DCO covers the AI-used-for attestation, is a pretty good 
replacement.  Something like:

---
In order to certify the provenance of AI/LLM-generated code that you
submit to QEMU, you must follow the policies outlined in this document
and in QEMU's ``AGENTS.md``.  **By using 'AI-used-for', a contributor
both identifies areas of the patch that involved use of AI/LLM, and also
attests that their usage of AI/LLMs was in compliance with the policies
outlined in this document.**
---

Paolo


