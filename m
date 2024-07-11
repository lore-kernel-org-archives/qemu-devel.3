Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3B7C3271E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 07:27:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRoCY-0008VO-Ry; Thu, 11 Jul 2024 03:26:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+c45b4986abac73e3a3bc+7627+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1sRoCQ-00086v-68
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:26:42 -0400
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+c45b4986abac73e3a3bc+7627+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1sRoCM-0000Ux-4A
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 03:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=MIME-Version:Content-Type:References:
 In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=KgLiby4/68MAQWchOfYKT/CVLhVlWjCktOMzovUhSSc=; b=QNjgHPqX6qp4qY9h58Y9zsTfTJ
 uRVkZRBL0EJHIChTy8iKQAQAdoRhsLEkU1dstWrjde/q/6csTpOU2PFQ1+tWOYcQ9Y+slBlP/CTjP
 9m/HdrsM5Nno6MUxktuJWOeddEqrNIm7063JGdoaHmjDEPyz6L3Yp9ijRrRgBoTvwk6mAeNClD8Bn
 OqiPy0tcj8aEmA227naCxde08DJ6x7jTLkx85omeZ0Bta05gVi0FfrMRVmWtSP1lWOoSJ7Nmoixru
 Q3TyzVL9Sy9PTQtjcnl2shdk5GuhU42jBGn7zgN37EvSjLKV5kfR7aXVhTi6CGcrKj8O7RmLXjeGv
 vEBNKXDQ==;
Received: from [2001:8b0:10b:5:daed:e261:1c9e:7a77]
 (helo=u3832b3a9db3152.ant.amazon.com)
 by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1sRoCE-0000000AgBV-3gcz; Thu, 11 Jul 2024 07:26:30 +0000
Message-ID: <b37283824ff4b7c6cc3a0c51199e6aa9b4b658a3.camel@infradead.org>
Subject: Re: More than 255 vcpus Windows VM setup without viommu ?
From: David Woodhouse <dwmw2@infradead.org>
To: Sandesh Patel <sandesh.patel@nutanix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Rob Scheepens
 <rob.scheepens@nutanix.com>, Prerna Saxena <confluence@nutanix.com>, Dexuan
 Cui <decui@microsoft.com>, Alexander Graf <alex@csgraf.de>
Date: Thu, 11 Jul 2024 08:26:30 +0100
In-Reply-To: <39b92288418839e9cdba447705a44a8e216dedc3.camel@infradead.org>
References: <B75A5788-630B-4898-8758-52B57D3D5895@nutanix.com>
 <3bb7c269ab0a13fe4398d2c7920d2f6bf8e86d47.camel@infradead.org>
 <7BBA47BD-AC3D-4F12-A860-AD3F2B509257@nutanix.com>
 <39b92288418839e9cdba447705a44a8e216dedc3.camel@infradead.org>
Content-Type: multipart/signed; micalg="sha-256";
 protocol="application/pkcs7-signature"; 
 boundary="=-nccq4CO2Ey0KFd3M6ePG"
User-Agent: Evolution 3.44.4-0ubuntu2 
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+c45b4986abac73e3a3bc+7627+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


--=-nccq4CO2Ey0KFd3M6ePG
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-07-08 at 10:13 +0100, David Woodhouse wrote:
> On Wed, 2024-07-03 at 16:01 +0000, Sandesh Patel wrote:
> > >=20
> > > Interesting. What exactly has Windows *done* in those MSI entries?
> > > That might give a clue about how to support it.

I repeated my experiment with interrupt-only remapping (no DMA
remapping). On two hosts:



vendor_id       : AuthenticAMD
cpu family      : 25
model           : 17
model name      : AMD EPYC 9R14 96-Core Processor

vendor_id       : GenuineIntel
cpu family      : 6
model           : 143
model name      : Intel(R) Xeon(R) Platinum 8488C

I used identical command lines on both, and on each host I got the same
result with all of '-cpu host', '-cpu EPYC' and -cpu Skylake-Server'.
It's the *host* that makes the difference, not the CPUID presented to
the guest.

On the Intel host it boots:

$ ./qemu-system-x86_64 -accel kvm,kernel-irqchip=3Dsplit -cdrom ~/Win10_22H=
2_EnglishInternational_x64v1.iso  -m 16G -M q35 -smp 2,cores=3D12,threads=
=3D2,maxcpus=3D288 -accel kvm,kernel-irqchip=3Dsplit -device intel-iommu,in=
tremap=3Don,dma-translation=3Doff -cpu Skylake-Server --trace vtd_ir_\* --t=
race apic\* --trace kvm_irqchip\* =20
qemu-system-x86_64: -accel kvm,kernel-irqchip=3Dsplit: warning: Number of h=
otpluggable cpus requested (288) exceeds the recommended cpus supported by =
KVM (192)
kvm_irqchip_add_msi_route dev N/A vector 0 virq 0
kvm_irqchip_add_msi_route dev N/A vector 0 virq 1
kvm_irqchip_add_msi_route dev N/A vector 0 virq 2
kvm_irqchip_add_msi_route dev N/A vector 0 virq 3
kvm_irqchip_add_msi_route dev N/A vector 0 virq 4
kvm_irqchip_add_msi_route dev N/A vector 0 virq 5
kvm_irqchip_add_msi_route dev N/A vector 0 virq 6
kvm_irqchip_add_msi_route dev N/A vector 0 virq 7
kvm_irqchip_add_msi_route dev N/A vector 0 virq 8
kvm_irqchip_add_msi_route dev N/A vector 0 virq 9
kvm_irqchip_add_msi_route dev N/A vector 0 virq 10
kvm_irqchip_add_msi_route dev N/A vector 0 virq 11
kvm_irqchip_add_msi_route dev N/A vector 0 virq 12
kvm_irqchip_add_msi_route dev N/A vector 0 virq 13
kvm_irqchip_add_msi_route dev N/A vector 0 virq 14
kvm_irqchip_add_msi_route dev N/A vector 0 virq 15
kvm_irqchip_add_msi_route dev N/A vector 0 virq 16
kvm_irqchip_add_msi_route dev N/A vector 0 virq 17
kvm_irqchip_add_msi_route dev N/A vector 0 virq 18
kvm_irqchip_add_msi_route dev N/A vector 0 virq 19
kvm_irqchip_add_msi_route dev N/A vector 0 virq 20
kvm_irqchip_add_msi_route dev N/A vector 0 virq 21
kvm_irqchip_add_msi_route dev N/A vector 0 virq 22
kvm_irqchip_add_msi_route dev N/A vector 0 virq 23
kvm_irqchip_commit_routes=20
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
07H:EBX.hle [bit 4]
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
07H:EBX.rtm [bit 11]
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
07H:EBX.hle [bit 4]
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
07H:EBX.rtm [bit 11]
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
vtd_ir_enable enable 1
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
vtd_ir_remap_msi_req addr 0xfee00010 data 0xd1 sid 0xffff do_fault 0
vtd_ir_irte_get index 0 low 0x0 high 0x100d10005
vtd_ir_remap index 0 trigger 0 vector 209 deliver 0 dest 0x1 mode 1
vtd_ir_remap_type IOAPIC
vtd_ir_remap_msi (addr 0xfee00010, data 0xd1) -> (addr 0xfee01004, data 0x4=
0d1)
kvm_irqchip_update_msi_route Updating MSI route virq=3D2
kvm_irqchip_commit_routes=20
vtd_ir_remap_msi_req addr 0xfee00010 data 0xd1 sid 0xffff do_fault 0
vtd_ir_irte_get index 0 low 0x0 high 0x100d10005
vtd_ir_remap index 0 trigger 0 vector 209 deliver 0 dest 0x1 mode 1
vtd_ir_remap_type IOAPIC
vtd_ir_remap_msi (addr 0xfee00010, data 0xd1) -> (addr 0xfee01004, data 0x4=
0d1)
kvm_irqchip_update_msi_route Updating MSI route virq=3D2
kvm_irqchip_commit_routes=20
...


On the AMD host it stops at the boot splash screen:

$ ./qemu-system-x86_64 -accel kvm,kernel-irqchip=3Dsplit -cdrom ~/Win10_22H=
2_EnglishInternational_x64v1.iso  -m 16G -M q35 -smp 2,cores=3D12,threads=
=3D2,maxcpus=3D288 -accel kvm,kernel-irqchip=3Dsplit -device intel-iommu,in=
tremap=3Don,dma-translation=3Doff -cpu  Skylake-Server --trace vtd_ir_\* --=
trace apic\* --trace kvm_irqchip\*=20
qemu-system-x86_64: -accel kvm,kernel-irqchip=3Dsplit: warning: Number of h=
otpluggable cpus requested (288) exceeds the recommended cpus supported by =
KVM (192)
kvm_irqchip_add_msi_route dev N/A vector 0 virq 0
kvm_irqchip_add_msi_route dev N/A vector 0 virq 1
kvm_irqchip_add_msi_route dev N/A vector 0 virq 2
kvm_irqchip_add_msi_route dev N/A vector 0 virq 3
kvm_irqchip_add_msi_route dev N/A vector 0 virq 4
kvm_irqchip_add_msi_route dev N/A vector 0 virq 5
kvm_irqchip_add_msi_route dev N/A vector 0 virq 6
kvm_irqchip_add_msi_route dev N/A vector 0 virq 7
kvm_irqchip_add_msi_route dev N/A vector 0 virq 8
kvm_irqchip_add_msi_route dev N/A vector 0 virq 9
kvm_irqchip_add_msi_route dev N/A vector 0 virq 10
kvm_irqchip_add_msi_route dev N/A vector 0 virq 11
kvm_irqchip_add_msi_route dev N/A vector 0 virq 12
kvm_irqchip_add_msi_route dev N/A vector 0 virq 13
kvm_irqchip_add_msi_route dev N/A vector 0 virq 14
kvm_irqchip_add_msi_route dev N/A vector 0 virq 15
kvm_irqchip_add_msi_route dev N/A vector 0 virq 16
kvm_irqchip_add_msi_route dev N/A vector 0 virq 17
kvm_irqchip_add_msi_route dev N/A vector 0 virq 18
kvm_irqchip_add_msi_route dev N/A vector 0 virq 19
kvm_irqchip_add_msi_route dev N/A vector 0 virq 20
kvm_irqchip_add_msi_route dev N/A vector 0 virq 21
kvm_irqchip_add_msi_route dev N/A vector 0 virq 22
kvm_irqchip_add_msi_route dev N/A vector 0 virq 23
kvm_irqchip_commit_routes=20
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
07H:EBX.hle [bit 4]
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
07H:EBX.rtm [bit 11]
qemu-system-x86_64: warning: This family of AMD CPU doesn't support hyperth=
reading(2). Please configure -smp options properly or try enabling topoext =
feature.
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
07H:EBX.hle [bit 4]
qemu-system-x86_64: warning: host doesn't support requested feature: CPUID.=
07H:EBX.rtm [bit 11]
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
vtd_ir_enable enable 1
kvm_irqchip_commit_routes=20
kvm_irqchip_commit_routes=20
vtd_ir_remap_msi_req addr 0xfee00004 data 0x0 sid 0xffff do_fault 0
vtd_ir_remap_msi (addr 0xfee00004, data 0x0) -> (addr 0xfee00004, data 0x0)
kvm_irqchip_update_msi_route Updating MSI route virq=3D2
kvm_irqchip_commit_routes=20
^Cqemu: terminating on signal 2


It looks like Windows is putting something bogus into the IOAPIC RTE for ir=
q2?
In the successful boot that was 0xfee00010 / 0xd1; vector 209 on CPU0.


--=-nccq4CO2Ey0KFd3M6ePG
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEkQw
ggYQMIID+KADAgECAhBNlCwQ1DvglAnFgS06KwZPMA0GCSqGSIb3DQEBDAUAMIGIMQswCQYDVQQG
EwJVUzETMBEGA1UECBMKTmV3IEplcnNleTEUMBIGA1UEBxMLSmVyc2V5IENpdHkxHjAcBgNVBAoT
FVRoZSBVU0VSVFJVU1QgTmV0d29yazEuMCwGA1UEAxMlVVNFUlRydXN0IFJTQSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eTAeFw0xODExMDIwMDAwMDBaFw0zMDEyMzEyMzU5NTlaMIGWMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYD
VQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50
aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
AQEAyjztlApB/975Rrno1jvm2pK/KxBOqhq8gr2+JhwpKirSzZxQgT9tlC7zl6hn1fXjSo5MqXUf
ItMltrMaXqcESJuK8dtK56NCSrq4iDKaKq9NxOXFmqXX2zN8HHGjQ2b2Xv0v1L5Nk1MQPKA19xeW
QcpGEGFUUd0kN+oHox+L9aV1rjfNiCj3bJk6kJaOPabPi2503nn/ITX5e8WfPnGw4VuZ79Khj1YB
rf24k5Ee1sLTHsLtpiK9OjG4iQRBdq6Z/TlVx/hGAez5h36bBJMxqdHLpdwIUkTqT8se3ed0PewD
ch/8kHPo5fZl5u1B0ecpq/sDN/5sCG52Ds+QU5O5EwIDAQABo4IBZDCCAWAwHwYDVR0jBBgwFoAU
U3m/WqorSs9UgOHYm8Cd8rIDZsswHQYDVR0OBBYEFAnA8vwL2pTbX/4r36iZQs/J4K0AMA4GA1Ud
DwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEF
BQcDBDARBgNVHSAECjAIMAYGBFUdIAAwUAYDVR0fBEkwRzBFoEOgQYY/aHR0cDovL2NybC51c2Vy
dHJ1c3QuY29tL1VTRVJUcnVzdFJTQUNlcnRpZmljYXRpb25BdXRob3JpdHkuY3JsMHYGCCsGAQUF
BwEBBGowaDA/BggrBgEFBQcwAoYzaHR0cDovL2NydC51c2VydHJ1c3QuY29tL1VTRVJUcnVzdFJT
QUFkZFRydXN0Q0EuY3J0MCUGCCsGAQUFBzABhhlodHRwOi8vb2NzcC51c2VydHJ1c3QuY29tMA0G
CSqGSIb3DQEBDAUAA4ICAQBBRHUAqznCFfXejpVtMnFojADdF9d6HBA4kMjjsb0XMZHztuOCtKF+
xswhh2GqkW5JQrM8zVlU+A2VP72Ky2nlRA1GwmIPgou74TZ/XTarHG8zdMSgaDrkVYzz1g3nIVO9
IHk96VwsacIvBF8JfqIs+8aWH2PfSUrNxP6Ys7U0sZYx4rXD6+cqFq/ZW5BUfClN/rhk2ddQXyn7
kkmka2RQb9d90nmNHdgKrwfQ49mQ2hWQNDkJJIXwKjYA6VUR/fZUFeCUisdDe/0ABLTI+jheXUV1
eoYV7lNwNBKpeHdNuO6Aacb533JlfeUHxvBz9OfYWUiXu09sMAviM11Q0DuMZ5760CdO2VnpsXP4
KxaYIhvqPqUMWqRdWyn7crItNkZeroXaecG03i3mM7dkiPaCkgocBg0EBYsbZDZ8bsG3a08LwEsL
1Ygz3SBsyECa0waq4hOf/Z85F2w2ZpXfP+w8q4ifwO90SGZZV+HR/Jh6rEaVPDRF/CEGVqR1hiuQ
OZ1YL5ezMTX0ZSLwrymUE0pwi/KDaiYB15uswgeIAcA6JzPFf9pLkAFFWs1QNyN++niFhsM47qod
x/PL+5jR87myx5uYdBEQkkDc+lKB1Wct6ucXqm2EmsaQ0M95QjTmy+rDWjkDYdw3Ms6mSWE3Bn7i
5ZgtwCLXgAIe5W8mybM2JzCCBhQwggT8oAMCAQICEQDGvhmWZ0DEAx0oURL6O6l+MA0GCSqGSIb3
DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNlY3RpZ28g
UlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMB4XDTIyMDEwNzAw
MDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJARYTZHdtdzJAaW5mcmFkZWFkLm9y
ZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3GpC2bomUqk+91wLYBzDMcCj5C9m6
oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZHh7htyAkWYVoFsFPrwHounto8xTsy
SSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT9YgcBqKCo65pTFmOnR/VVbjJk4K2
xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNjP+qDrh0db7PAjO1D4d5ftfrsf+kd
RR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy2U+eITZ5LLE5s45mX2oPFknWqxBo
bQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3BgBEmfsYWlBXO8rVXfvPgLs32VdV
NZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/7auNVRmPB3v5SWEsH8xi4Bez2V9U
KxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmdlFYhAflWKQ03Ufiu8t3iBE3VJbc2
5oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9aelIl6vtbhMA+l0nfrsORMa4kobqQ5
C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMBAAGjggHMMIIByDAfBgNVHSMEGDAW
gBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeDMcimo0oz8o1R1Nver3ZVpSkwDgYD
VR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYwFAYIKwYBBQUHAwQGCCsGAQUFBwMC
MEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYBBQUHAgEWF2h0dHBzOi8vc2VjdGln
by5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwuc2VjdGlnby5jb20vU2VjdGln
b1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1haWxDQS5jcmwwgYoGCCsGAQUFBwEB
BH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdvLmNvbS9TZWN0aWdvUlNBQ2xpZW50
QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAjBggrBgEFBQcwAYYXaHR0cDovL29j
c3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkqhkiG9w0B
AQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQvQ/fzPXmtR9t54rpmI2TfyvcKgOXp
qa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvIlSPrzIB4Z2wyIGQpaPLlYflrrVFK
v9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9ChWFfgSXvrWDZspnU3Gjw/rMHrGnql
Htlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0whpBtXdyDjzBtQTaZJ7zTT/vlehc/
tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9IzCCBhQwggT8oAMCAQICEQDGvhmW
Z0DEAx0oURL6O6l+MA0GCSqGSIb3DQEBCwUAMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3Jl
YXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0
ZWQxPjA8BgNVBAMTNVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJl
IEVtYWlsIENBMB4XDTIyMDEwNzAwMDAwMFoXDTI1MDEwNjIzNTk1OVowJDEiMCAGCSqGSIb3DQEJ
ARYTZHdtdzJAaW5mcmFkZWFkLm9yZzCCAiIwDQYJKoZIhvcNAQEBBQADggIPADCCAgoCggIBALQ3
GpC2bomUqk+91wLYBzDMcCj5C9m6oZaHwvmIdXftOgTbCJXADo6G9T7BBAebw2JV38EINgKpy/ZH
h7htyAkWYVoFsFPrwHounto8xTsySSePMiPlmIdQ10BcVSXMUJ3Juu16GlWOnAMJY2oYfEzmE7uT
9YgcBqKCo65pTFmOnR/VVbjJk4K2xE34GC2nAdUQkPFuyaFisicc6HRMOYXPuF0DuwITEKnjxgNj
P+qDrh0db7PAjO1D4d5ftfrsf+kdRR4gKVGSk8Tz2WwvtLAroJM4nXjNPIBJNT4w/FWWc/5qPHJy
2U+eITZ5LLE5s45mX2oPFknWqxBobQZ8a9dsZ3dSPZBvE9ZrmtFLrVrN4eo1jsXgAp1+p7bkfqd3
BgBEmfsYWlBXO8rVXfvPgLs32VdVNZxb/CDWPqBsiYv0Hv3HPsz07j5b+/cVoWqyHDKzkaVbxfq/
7auNVRmPB3v5SWEsH8xi4Bez2V9UKxfYCnqsjp8RaC2/khxKt0A552Eaxnz/4ly/2C7wkwTQnBmd
lFYhAflWKQ03Ufiu8t3iBE3VJbc25oMrglj7TRZrmKq3CkbFnX0fyulB+kHimrt6PIWn7kgyl9ae
lIl6vtbhMA+l0nfrsORMa4kobqQ5C5rveVgmcIad67EDa+UqEKy/GltUwlSh6xy+TrK1tzDvAgMB
AAGjggHMMIIByDAfBgNVHSMEGDAWgBQJwPL8C9qU21/+K9+omULPyeCtADAdBgNVHQ4EFgQUzMeD
Mcimo0oz8o1R1Nver3ZVpSkwDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwHQYDVR0lBBYw
FAYIKwYBBQUHAwQGCCsGAQUFBwMCMEAGA1UdIAQ5MDcwNQYMKwYBBAGyMQECAQEBMCUwIwYIKwYB
BQUHAgEWF2h0dHBzOi8vc2VjdGlnby5jb20vQ1BTMFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9j
cmwuc2VjdGlnby5jb20vU2VjdGlnb1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5kU2VjdXJlRW1h
aWxDQS5jcmwwgYoGCCsGAQUFBwEBBH4wfDBVBggrBgEFBQcwAoZJaHR0cDovL2NydC5zZWN0aWdv
LmNvbS9TZWN0aWdvUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNydDAj
BggrBgEFBQcwAYYXaHR0cDovL29jc3Auc2VjdGlnby5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5m
cmFkZWFkLm9yZzANBgkqhkiG9w0BAQsFAAOCAQEAyW6MUir5dm495teKqAQjDJwuFCi35h4xgnQv
Q/fzPXmtR9t54rpmI2TfyvcKgOXpqa7BGXNFfh1JsqexVkIqZP9uWB2J+uVMD+XZEs/KYNNX2PvI
lSPrzIB4Z2wyIGQpaPLlYflrrVFKv9CjT2zdqvy2maK7HKOQRt3BiJbVG5lRiwbbygldcALEV9Ch
WFfgSXvrWDZspnU3Gjw/rMHrGnqlHtlyebp3pf3fSS9kzQ1FVtVIDrL6eqhTwJxe+pXSMMqFiN0w
hpBtXdyDjzBtQTaZJ7zTT/vlehc/tDuqZwGHm/YJy883Ll+GP3NvOkgaRGWEuYWJJ6hFCkXYjyR9
IzGCBMcwggTDAgEBMIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVz
dGVyMRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMT
NVNlY3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA
xr4ZlmdAxAMdKFES+jupfjANBglghkgBZQMEAgEFAKCCAeswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMjQwNzExMDcyNjMwWjAvBgkqhkiG9w0BCQQxIgQgRTjJEFVi
mh5YHMY6hzIVO1tNKlrbMbvqNbRMCqZG0e8wgb0GCSsGAQQBgjcQBDGBrzCBrDCBljELMAkGA1UE
BhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2FsZm9yZDEYMBYG
A1UEChMPU2VjdGlnbyBMaW1pdGVkMT4wPAYDVQQDEzVTZWN0aWdvIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAMa+GZZnQMQDHShREvo7qX4wgb8GCyqGSIb3
DQEJEAILMYGvoIGsMIGWMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVy
MRAwDgYDVQQHEwdTYWxmb3JkMRgwFgYDVQQKEw9TZWN0aWdvIExpbWl0ZWQxPjA8BgNVBAMTNVNl
Y3RpZ28gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEAxr4Z
lmdAxAMdKFES+jupfjANBgkqhkiG9w0BAQEFAASCAgBg8dY04dAhSAPJqagn4AEb2EtR7bRRZa+/
XbrJtsvDZU0penYYAO9nrS1y5lEp1DjMP5ub+VNrKPt9+Pck7HfHAYWjzSHEJTR66RRduK4Bhb8D
8ivrtlYTmVKzXykEex1mg1le47WG3DpBIZeN/pSFyjTqoMaMFk/NorwyrNqYvDhdbjGhDrtgHA9+
EIZVf7xiFD7xERhJ41HDA8y0YsvAwIK6aqWD4vkoIE1aLBgnAWf3GoBt1iQ0epwzKkflQFEO4CiD
zW5vTR2HF/I58yS0vf7xzlDeom1Py3H2AumA2tfuNzUqSws/yWlMZBwmhztynMNxBkSti0kHg1Vl
sRntC6R4oBWZE0qyc/10NlumMTN88BZPtpGl9blKdD6Hpqs97w0f/mGQmeUlASUyjWuH70kStoos
bkRTIkkpEX/aBq55c/Z/YAbx94CBVqz730rmGdb/iZTehKArWmeARoupwzR9l7zgcnmJert4BzhF
4DWfa71eOIw4Flgu09u80S4U0ESCOEaacltwivOy71BaR7pSKPmMrKt5cwQNz8EMQHXcpOT0ACBA
uD4Yk15Z9y8FIlJk3NgFYjBc3Tr95hj/qfIlrqAM+FKKk76X22nUCINzhiNplZUB3FpuNtR0qIIB
ITefopbmgeEtRqnL1qBm4RfKJiOHXfUq7voWqha1zgAAAAAAAA==


--=-nccq4CO2Ey0KFd3M6ePG--

