Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F50606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ex9ZA5sO;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LM7VfUQc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWiDO-00018M-HS; Thu, 26 Nov 2026 17:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWiDN-00016c-BM
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:45:17 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xWiDL-0006Vk-JE
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:45:17 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AQJx2M31713354
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:45:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xynKYx+nxr48g9DIUKwfNykU/ghDOrGL/9YgoD2wNk8=; b=Ex9ZA5sOxy/g1Mvy
 wl0Qq6PxAd7MWq8oEYzmk/oLZIRs+TJ/N3/TcESgQcpc/q/mTIO9tp56Nh9J/to6
 zjSeFPZzDBEg/at6HMu5jGM9od+8zDlRL3gjSsCMZTgF6vvfiemZFcqiQ/Ujea/O
 fBKuWntV5Pb4KBZtHeC04l4c5UdNUaqvTcs1/jubbPyS+6N8kJhNPqXH2+oBKeMD
 VjaMb0by1SPESvKqdP9n5UUaCG+b1ftvosdvvGWWxRnKHgsZujQ533LykDkxBfL7
 iiQD7DlPGjnsjwPOztxTigI5ee/HdtUTmTu48gKE+MGUc2uwZK+O1QCgj5xi5OC2
 0kC3TQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6gne2rrr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 22:45:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-949b0d322fcso1238166985a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Nov 2026 14:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795733113; x=1796337913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xynKYx+nxr48g9DIUKwfNykU/ghDOrGL/9YgoD2wNk8=;
 b=LM7VfUQc5FUpoHqIxadXvIrQm/jn4EPue0W+CttxFEY80BiKbZvty9cNiqJikHEISc
 WlYrWdRFqW88vqcwANMGKqa9KcYp/e7VUFmolXzgeK0t1nt+O91yS7VderzPo9ciXj6V
 miTDGdB2l4JX6fbwON1tD5jMuNhcRQ6DNZ3Fyk9hNK5uOReLd0BmypSsUsYLE7CxHH73
 K5z1zNMcKSsqhAJaTZutB0A6ujOurMa3924pYmP9WU2NmwIkUkuu+Su3l93T4UOCktkg
 T7nRARtWMwYqVTOmygmndtYCTk0k+R25h+V1Q0tTW6cmXKX0TwIS1WgJfXQ1pWRMRkBP
 vTaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795733113; x=1796337913;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xynKYx+nxr48g9DIUKwfNykU/ghDOrGL/9YgoD2wNk8=;
 b=Mg8zrfMD4jiDZzks74fHwQw+JWWEvp+5A8zVbdl9NIfShySzP3pQgVIJPc2nRRxdAX
 C26qEsa9NONtYPfisDm5qm4zB0ihevTxnA8X68DDMRpz6AO8OqQqyDTIGE30y2j62xfH
 1vsfxiBUegmbACZblujNk2++uCUQJy0X7X8BZJ24/CBDkEubbE4rmljgKddE9Ik1Jf+j
 3+tZSye/ixGf8IU2sNntpUVksPIfz/WkCKQR/bWKXuVRLeyfdvkrhO0liWXNLeRjrJF4
 VbgBo+XCbaSma1oNBV3fyer8YIeVRSi9+I2/2iCq4ex1dhKbdm5/jKXx9y+sMCHGMgjb
 BFfA==
X-Gm-Message-State: APuU4Z/dQJGRzImcZfsQCKEt0ECQBXkStCf63iPunIedtYOoV2DQFUte
 Nihz+0cvyQQwGcNZMSswboGOrBboxIUeeiqdaMfetm1mZqX7TtH2sZtxmGb4g9n9KSEftGmcYhh
 nLbxg8UfilN66BYmVkXl+hw1Q9aMZVp+ziY4nh9w5ihw3/oDy25xbEpjEjg==
X-Gm-Gg: AZFdTZdjk4OJdiyLr8OuAQZhaklgz9gHzYZJw9A47q/4DeL7jlNvmi39DiUn25KCJ4X
 Gyct0ezZTEb1/mtxeMSyLnvN8wTDFZ+EnFY2OnQb/aRFFbqbL2EpDzymRAWIG6tAiaGQHrDKCos
 l/nllkC+5pOcLQurMWhh6ixuNgyoNdI20WtQV34rXYRPjcc4wPAOuMON+D3OzkEZ1SaiT8sdVzI
 C8UPLEK53kjiHXQ2NEX0AVSuC1j4/qHH1Ko+6NTElegfXmU2us+Mencagi9kgkRQQkIkcASpYUX
 gl1qVAjpA2exiE44XEi/+3pee5xA6dAFnUpJBpUSUtBMPzPwRcYfVJyFKoWWyugDWoYLhrOStO/
 nPOrwjckuESJlOGTtmMs1YEb+9WfsX3q79pn0aSIyKiKGDrNNK2e5rJCbPTbkPshoHQONVnVZf5
 R32R/UWAw=
X-Received: by 2002:a05:620a:45a8:b0:947:b201:fad7 with SMTP id
 af79cd13be357-949bab0eeb3mr4040408185a.67.1795733113226; 
 Thu, 26 Nov 2026 14:45:13 -0800 (PST)
X-Received: by 2002:a05:620a:45a8:b0:947:b201:fad7 with SMTP id
 af79cd13be357-949bab0eeb3mr4040402385a.67.1795733112726; 
 Thu, 26 Nov 2026 14:45:12 -0800 (PST)
Received: from [192.168.69.202] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a680483sm43762069f8f.28.2026.11.26.14.45.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Nov 2026 14:45:11 -0800 (PST)
Message-ID: <61c71bb9-c9b1-462b-893b-c09d0322785f@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 23:45:10 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] system/memory: Display address spaces starting at
 0x0000.0000
Content-Language: en-US
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
References: <20260226220226.20164-1-philmd@linaro.org>
 <20260226220226.20164-6-philmd@linaro.org> <aah40xnBszzsWyT0@x1.local>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <aah40xnBszzsWyT0@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XpVvqlF9 c=1 sm=1 tr=0 ts=6b08b67a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=wrFheHMyYtGgnyQavWgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfXydjP7oU9Np/O
 f7J7aXH88JHc7S1+UWRtlY09ygekFURZp679AAIUErTB6sqk77tuPCBUNtB7aP6YecH6FR7QLXJ
 osWG1/tf+cV9IBCD+bGSoX7N3PRemVzHdyertKoKuvI+JpX4M9Ws70FEVntWXUBMUNKLf8o4Jq2
 7dNR0Z2Cr6QDVdP+ZUyOi3wjjwQpI4xYPt7+szW7Nd5Go4nxoUyq+s6q8+sRJghWfO8GXDG9yrV
 xlBAnkEDkk1zmDmewniWJytWP2cKijdzWjCplKjj77Jp1W4UPdP4PgSfMkq+t2qHihVO4Ie/b19
 jJfoXylnr0bagr3doNuAq5JIG1ZSLHb6ognIktMuZq68C1446r2rwLXMYU4quqPMptIW/8mxLlX
 iK4ffZrVNFq5FeXtjaOExz8BspgVJmTLz0W0P2eLfnOAf/M4dTRoWXd2IAqyM5dQ0XCtycp/Bte
 Ydq4bncQRQEWs38PN0A==
X-Proofpoint-GUID: Gml2ZzCKNmEEBjFcjdDffx7Cw_ddrZTc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfXyJIDMOzN9JC9
 sG106SEhszY2xZmvIf40NbZn8P4NzCbcRdlaWU7ECb/Ks6GIYYQhHe0oHNMRMKuh9OEoFp8eKaQ
 /rykHJA+frO/Eqa49AdLE/tktRjHsoM=
X-Proofpoint-ORIG-GUID: Gml2ZzCKNmEEBjFcjdDffx7Cw_ddrZTc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-26_05,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611260089
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter :)

On 4/3/26 19:24, Peter Xu wrote:
> Hi, Phil!
> 
> On Thu, Feb 26, 2026 at 11:02:23PM +0100, Philippe Mathieu-Daudé wrote:
>> Since AddressSpace root MemoryRegion can be remapped, it is
>> bogus to use the MemoryRegion address as the AddressSpace
>> absolute address. Besides, the AddressSpace APIs take an
>> @addr argument expecting AddressSpaces start at 0x0000.0000.
> 
> Could you share an example where a root MR can have addr!=0, and be
> remapped while being the root MR of an AS?

virtio-pci.

In virtio_pci_realize():

     memory_region_init(&proxy->modern_bar, OBJECT(proxy), "virtio-pci",
                        pow2ceil(proxy->notify.offset + 
proxy->notify.size));
     address_space_init(&proxy->modern_cfg_mem_as, &proxy->modern_bar,
                        "virtio-pci-cfg-mem-as");

then virtio_pci_device_plugged() registers the very same MR as BAR4:

     pci_register_bar(&proxy->pci_dev, proxy->modern_mem_bar_idx,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                      PCI_BASE_ADDRESS_MEM_PREFETCH |
                      PCI_BASE_ADDRESS_MEM_TYPE_64,
                      &proxy->modern_bar);

When the guest programs BAR4, pci_update_mappings() removes and
re-adds the MR at the new address, so modern_bar.addr follows the
guest, while modern_bar stays the root of modern_cfg_mem_as.

   $ qemu-system-x86_64 -M q35 -nodefaults \
       -device virtio-net-pci,disable-legacy=on,netdev=n0 \
       -netdev user,id=n0 -S
   (qemu) info mtree
   address-space: virtio-pci-cfg-mem-as
     0000000000000000-0000000000003fff (prio 0, container): virtio-pci
       0000000000000000-0000000000000fff (prio 0, i/o): 
virtio-pci-common-virtio-net
       0000000000001000-0000000000001fff (prio 0, i/o): 
virtio-pci-isr-virtio-net
       0000000000002000-0000000000002fff (prio 0, i/o): 
virtio-pci-device-virtio-net
       0000000000003000-0000000000003fff (prio 0, i/o): 
virtio-pci-notify-virtio-net

Once SeaBIOS assigned BAR4:

   (qemu) info pci
       BAR4: 64 bit prefetchable memory at 0xfebfc000 [0xfebfffff]
   (qemu) info mtree
   address-space: virtio-pci-cfg-mem-as
     00000000febfc000-00000000febfffff (prio 1, i/o): virtio-pci
       00000000febfc000-00000000febfcfff (prio 0, i/o): 
virtio-pci-common-virtio-net
       00000000febfd000-00000000febfdfff (prio 0, i/o): 
virtio-pci-isr-virtio-net
       00000000febfe000-00000000febfefff (prio 0, i/o): 
virtio-pci-device-virtio-net
       00000000febff000-00000000febfffff (prio 0, i/o): 
virtio-pci-notify-virtio-net

So the AS "moves" with the BAR. render_memory_region() adds the root
mr->addr, so this isn't only a display matter: the flatview itself
starts at root->addr.


A static (non-remapped) example where that matters is the PReP
Raven host bridge, whose PCI I/O MR is both mapped in the CPU view
at 0x80000000 and the root of the "raven-io" AS:

     memory_region_init(&s->pci_io, obj, "pci-io", 0x3f800000);
     address_space_init(&s->pci_io_as, &s->pci_io, "raven-io");
     memory_region_add_subregion(address_space_mem, PCI_IO_BASE_ADDR,
                                 &s->pci_io);

It is also the bus I/O space, so lsi53c810 on the 40p machine gets
the same root via pci_address_space_io():

   $ qemu-system-ppc -M 40p -S
   (qemu) info mtree
   address-space: lsi-pci-io
   address-space: raven-io
     0000000080000000-00000000bf7fffff (prio 0, i/o): pci-io
       0000000080000000-0000000080000007 (prio 0, i/o): dma-chan
       0000000080000020-0000000080000021 (prio 0, i/o): pic
       ...
       0000000080000cf8-0000000080000cfb (prio 0, i/o): pci-conf-idx
       0000000080000cfc-0000000080000cff (prio 0, i/o): pci-conf-data

The two users of this AS disagree on the origin:

- raven_io_read/write() rely on the current behavior and access
   pci_io_as at 'addr + PCI_IO_BASE_ADDR';

- lsi_mem_read/write() in I/O mode (DMODE.SIOM) pass a plain PCI I/O
   address, i.e. expect the AS to start at 0, so with the current
   flatview such accesses miss (e.g. port 0x20 is at 0x80000020 in
   lsi-pci-io).

This is what I meant by "AddressSpace APIs take an @addr expecting
AddressSpaces start at 0x0000.0000"; I'll clarify in v2.

Regards,

Phil.


