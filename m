Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76652C5CFC1
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2026 17:08:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuvNw-000262-EL; Fri, 14 Aug 2026 13:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wuvNo-00023O-N1
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:07:52 -0400
Received: from sonic303-24.consmr.mail.gq1.yahoo.com ([98.137.64.205])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <brchuckz@aol.com>) id 1wuvNm-0003N2-Gg
 for qemu-devel@nongnu.org; Fri, 14 Aug 2026 13:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1786727267; bh=UY+I4UqGSnIpDiJN8AUplsskjws3Y+OSbvdRYW7JPno=;
 h=Date:Subject:From:To:Cc:References:In-Reply-To:From:Subject:Reply-To;
 b=BfbomtQlNSINKeR60rhpLziDP1DxAHD6ngEt/Gff5VH97iO3hTsCGgI2KJ+ym1uc/yWmbySncIwRADbSiZpqr9FfN7YW5fajUCuiD9vMtcLe8LxE4f9GGYwiZ+eoLjSXT5xu34ZItjgnaAEI8+5FDpBpJ85RBWy5bzB34UaDR0iyWCxMtS8RKgsifJmCp6e7OrPBwavlfUGJWUdpeXkFqbjCF5jEM1hr7Z5+JIq+bsSr28zVw3laKd+K5e41eSjvdOTzoCqItrGVcD8n62QgtVdRyrcIMJUWbWoR4cR3V2ZmEjg1vBP0cDTirTek5p7FA7lGajzZsgTuAooYfklh4Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1786727267; bh=c39lbYaGJJoIE/qhea/ao2CxkL7OjjLdrbSLzWVUHJs=;
 h=X-Sonic-MF:Date:Subject:From:To:From:Subject;
 b=hNDy+a5sYYtLgboIHCp1Qcq0ohES12nsJh4n1yTM3tHBpXw5USle3m/qVodP0aXpDC5ZhPDQ9tqTHvkw0l0IX88pcx681PXPXsZuQ4Y9ZhnXxAClvbnx5NHmAN3QnwLv9tDBkEiyjuyjXAai9sG10OK9+jw+GWqmLQU/cISHzFB2JxFCKkyOaKBIfuAhq3oRt7k2OKDD7I/5G6zQTADCR8n25vztQgy2qDrSVXM9YisNXzNOCV+I+FH1tB6K9GbkPusFBb4Sf2vyR4SwXeykjxv/xruKhqKP3JTqyAW7s1RyOhXG+pgDvChG5Sqn1A+hoXIB1xZuayl4gQ9D8JqCBQ==
X-YMail-OSG: 8a2iFRQVM1lC0evxH.V2EkutHKBoXV3brFfmIDV7qQdtN5HbXc6Qi7Ov7kQiIiR
 UsbvpIRtPBz.uUgwf4Redp6xLr_DgmrIGmbMMVgQ13W2s96wLlNJJFjGQ.uSd9ZdPbN86l1CU7Db
 VdWLVICOwP5kb5ZYjG3O5MKeQIxRfQgkOpFIcSSunNieNGteF8V01DdHQDNougx7nIy8SqmcFwO5
 NlFRVaelWgP5f42Lgdmjl.VOgPzhgaPLp0R.9OnGD_c4P7ZBufVdk55JRJTkGWlGt_.t3KexRy1k
 z1IysH8oBWtI4m4asf7u914_PHoMbZyfdLbsQj9ET9uP605LdHxt5fEduNlDFUIPYQZfSkGuk6kk
 7lMjbJkaZ8qKflcdGE4aKmdEPOdoVDiIhoRKmy36BstJMS9M299Kw86glkEsbyQ7YjXRhRQRIxVR
 jPQ9oewICB5Kb07gNwtVweKv5_ahSw7DmwCEJaYgc2T94.awdXZTthhgWCqG4RwR0QQ.DsQp1mAZ
 Vlsf3DoEOEShsAyFkkhv3ifHNGaTsVSFHbH0Z19C4jri0DDBQO_EnJfhQFHxreLbXwm6Z7SoviI5
 q2mf0bmPDXi2cO3wjZOwd7rV2ZNr.Pzo4UuCox6VwpmrjYp34AKrPf2ExyBm7ZRm2on.LRZuPvLM
 VoY.KNZUjh5JpJyNXeQ1s85qAXY__TsGMidIvz8jYS9MsG.VuMga8NriuiklZxP9PB.VlXQ_MN_f
 Kvh2OPfH_qajbrzCNi2KBogpZFzrrm7re8QoULFNKD3E.Uu_noPWJX37h.GQUMLbgJXGhohucRqq
 nzNcX.4Z8EXgsUYuEqy8h1Isw3_8ribF6PSlWeLjyFr9GfjN7TKx0WxuU6P_PkJtq1_Fi2TcpEuo
 E7yvcHinxQBmLodID5mYvl39j8RgZtvgccIBSbxfXcbVZxuS_r6_s3dS_XtGWoEk7Hn040_CY3a4
 360F5JBdawUqL1UCSZ0aJA_TyRsgDFok89DcAoURetVx_5HJNIKkABN8.nRS7ZrpcwLSQPiAwIRn
 QNMzlBCCaOgW82MrbSdcHuBjD3.zHmieY6BaxugMIvT1eCsO74ysr6ed7FqAIhJ7pNDtxWItfcD5
 09w_tNV3jeWkAW5QxlMA7XG2BNnuDUR2kYQF6BUX0OMy8qRVZYvOb8vAQBaMCl_r4_OJwtFd9s7p
 wSQjAdzVC418z5.PzeP41UFtpmqsK6vRx7NFrzeZe2SrMVdgFp0IvgZh.fk5OeC7sfVomPJYnNVB
 XE4md11OY18SC2MhBieestlKn4rcAvPrFx9H7xPo_sDGFc5ksN.Nd.qRJ2cyWZeyrzsUuP.DJsRr
 dFpsTAZBUqgddIYi34rAgv__xpWN3mSnskebwdrETpwp9tD6SdyaCtrskRya.WrLxgpn4vgTCsPD
 IHAxbIXxzbhpApmKckdzgdLCNf3U6s2x55vd5_ddJyfoNegK4QhbeHiaLgjzhk18W03YtQDlnK0y
 cPBPMr3CEWGzLPppHvmVKWNAoGSWq4nNMSxPRJ.AY.WxpNW.RSZrwxAPrGtEzzqgN1RueR5Pg8Yd
 R8Ud0xWuwODjgZ9U6dMklXbH7hjUC_A..C0AkRMvNA8uhKsGJV55EyoNCLS5FjpC9GG19YqR2bWv
 M417BEaATPsT6XItbTpUVStn2o3.QPP3uMVLeQtAQTqZesWGQb5RxlRGITLtfHvJKe8Y1EgAAYpI
 qW9XrydEZH5U_YlNb6oLYFEDJrJgK8qvn8yXRIk40ipnFIH8mNGFL48keEnThRQarLaVRbZF9MkK
 QfYTckSiOWTsGWZH22reXk4xSHXDjaqqq4qs0_pcBhi2pVANhjNG3eGtIDo6FzKlX3203_YU3FeV
 jtb3RQhnBo9AKAAlp_kM23E.8oWCTg9wtRQaCBSN0HN6px0bCiuZo7dVcqKxYEQyNnPAg3fBCIKW
 ZJAiezeOYfKEnHTzJ0LZkKHW0AN37W58agpBFURz0LbXPpKkyXFLFeDeVfSdTDy.bKhBY_IogS6n
 ULp0UdbxYGlag.G8SoL2a4gPaINd9Sl3T3pDAltOIMTc3H8b7qVWSgiJ10LiXzY6ndtJIiMuy5DA
 PFKFLOYqZKmGRo3XNpKasHL8_OxvieKcmp0u3AvAf91oqY6jTRnLamgtIp3V8o9GSWxOy4ihsQaH
 75.JyPrD750BqFWotqESvwmz74Q329v0M6cjtGmgnfoDyC86zZNDi_IJTNUXTnmEsYiA0aoObW0e
 lrAGln2VeJhM8LWnsh4IJJoHaVcycgPJOSasV3fixQu7_ibQ-
X-Sonic-MF: <brchuckz@aol.com>
X-Sonic-ID: 18dd4469-32e4-4583-9cc9-9f8238f17af1
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Fri, 14 Aug 2026 17:07:47 +0000
Received: by hermes--production-ne1-6dbcb84f44-2jkrk (Yahoo Inc. Hermes SMTP
 Server) with ESMTPA ID fcaea302a7739d9747edaf46b5414c24; 
 Fri, 14 Aug 2026 17:07:45 +0000 (UTC)
Message-ID: <416caa9d-b658-4ba8-a401-babf477c0afe@aol.com>
Date: Fri, 14 Aug 2026 13:07:43 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools/hvmloader: implement Intel IGD extended VBT
 support
From: Chuck Zmudzinski <brchuckz@aol.com>
To: Jan Beulich <jbeulich@suse.com>
Cc: qemu-devel@nongnu.org, Andrew Cooper <andrew.cooper3@citrix.com>,
 =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger@xenproject.org>,
 Teddy Astie <teddy.astie@vates.tech>, Tomita Moeko <tomitamoeko@gmail.com>,
 xen-devel <xen-devel@lists.xenproject.org>,
 Anthony PERARD <anthony.perard@vates.tech>
References: <20260802050824.10554-1-brchuckz.ref@aol.com>
 <20260802050824.10554-1-brchuckz@aol.com>
 <2110d4b7-ae37-47aa-99be-ab59e16f6167@suse.com>
 <67579eba-e222-41dd-84bf-8440d2eaf2a9@netscape.net>
 <da2200cd-def7-4cce-a6c2-9f9ac9e202ce@suse.com>
 <de56c8bd-f0e8-4fe9-8cf5-f6807698176c@aol.com>
 <02a7dc18-4184-4e86-84cb-121769187f71@suse.com>
 <1858e8e6-73fa-4017-93e2-c733fbf0ec8d@aol.com>
Content-Language: en-US
In-Reply-To: <1858e8e6-73fa-4017-93e2-c733fbf0ec8d@aol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.26254
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
Received-SPF: pass client-ip=98.137.64.205; envelope-from=brchuckz@aol.com;
 helo=sonic303-24.consmr.mail.gq1.yahoo.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 8/14/2026 11:23 AM, Chuck Zmudzinski wrote:
> On 8/14/2026 9:46 AM, Jan Beulich wrote:
>> On 14.08.2026 15:18, Chuck Zmudzinski wrote:
>>> On 8/14/2026 3:35 AM, Jan Beulich wrote:
>>>> On 14.08.2026 02:45, Chuck Zmudzinski wrote:
>>>>> On 8/13/2026 6:35 AM, Jan Beulich wrote:
>>>>>> On 02.08.2026 07:08, Chuck Zmudzinski wrote:
>>>>>>> -- snip --
>> 
>>>>>>> +    pci_writel(vga_devfn, PCI_INTEL_OPREGION,
>>>>>>> +               (igd_opregion_pgbase << PAGE_SHIFT) |
>>>>>>> +                IGD_OPREGION2_SUPPORT_MASK);
>>>>>>
>>>>>> This looks to imply qemu is the only possible device model.
>>>>>
>>>>> Yeah, this is an issue. Other device models that intend to support
>>>>> the Intel IGD with hvmloader will also have to be compatible with this.
>>>>> It would be easier if we did not have to worry about backward
>>>>> compatibility and supporting what we had in the codebase for many years
>>>>> in both hvmloader and Qemu and we would not need IGD_OPREGION2_SUPPORT_MASK
>>>>> in that case. Instead, we would just completely deprecate all previous
>>>>> implementations of the Intel IGD passthrough feature in both hvmloader and
>>>>> the Qemu DM as unsupported. So my previous comments about backward
>>>>> compatibility apply here again.
>>>>
>>>> As said, I don't think backward compatibility can be dropped. My comment
>>>> also didn't really mean to hint in that direction. Instead I was wondering
>>>> in how far, even if perhaps by only a few #define-s, the necessary
>>>> interfacing couldn't be put down in a public header, for any DM to consume.
>>> 
>>> Ok. Perhaps the IGD_* defines could be moved to a public header to define the
>>> interface to be used to support the Intel IGD. Would it be OK to move those
>>> to a separate igd.h header
>> 
>> This may require input by others, as in the given situation I'm not quite
>> sure what is best. Anthony - do you possibly have any suggestion here?
>> 
>>> and include it in hvmloader/config.h?
>> 
>> I don't see why that would be needed. The few files which need the #define-s
>> can include that new public header, without impacting anything else.
> 
> So I would just include it in the new intel-opregion.c file. Also, maybe igd-related
> declarations should be moved there too, such as the currently existing extern variable
> igd_opregion_pgbase and my newly proposed extern variable igd_opregion_e820_pages,
> which would mean the new header would also need to be included in hvmloader/e820.c.

Actually, those igd-related declarations do not need to be in a public header. But I
think if we go to a public header for any DM to consume, we need to fixup oddities
like the current definition of IGD_OPREGION_PAGES of 3 when the actual number of pages
in the OpRegion is exactly 2. So I propose the next version of this patch should
add a preliminary patch to cleanup the oddities in the current implementation such as
having IGD_OPREGION_PAGES set to 3 without introducing any functional change by
redefining IGD_OPREGION_PAGES to the value it should be, which is 2. Then we can
include IGD_OPREGION2_SUPPORT_MASK, IGD_OPREGION_PAGES, etc. as defines in a public
header for any DM to consume. I can probably build such a public header directly from
IGD-related header files in use in the Linux kernel or in the Qemu/vfio IGD-related
headers files.

Chuck

