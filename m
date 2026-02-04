Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 956C5E83041
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 06:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnWbO-0006CH-Di; Wed, 04 Feb 2026 01:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnWbI-00069Q-DB
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 01:42:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vnWbD-0004ku-1d
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 01:42:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770187369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cIKuDVWrmwsDYfsEMIyqgWJoMDF4gy/wdB7kJv+fqRk=;
 b=cdiuGWBAMUpcnzSdItDUkowFvVkW/PejmpltT59tWuen5mD+QAScwd5410QyJrHdjV4ty+
 OKwqFITgyIGTvKH2h1Dy4GHPxN2kssFEIq33mrMBu2y4mpdt+WU+0e9SLmZMB6ilqUZRhW
 feUdkyff2ZgQyK5ETl8EFZYLyj2Lo44=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-kuwDIT3cOdCEGgZgNyu-UA-1; Wed, 04 Feb 2026 01:42:48 -0500
X-MC-Unique: kuwDIT3cOdCEGgZgNyu-UA-1
X-Mimecast-MFC-AGG-ID: kuwDIT3cOdCEGgZgNyu-UA_1770187367
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4358f1c082eso310313f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 22:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770187367; x=1770792167; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cIKuDVWrmwsDYfsEMIyqgWJoMDF4gy/wdB7kJv+fqRk=;
 b=HTJKxZg4w36ud3zfCFSO2/BgiNVfUj8DN6YjXhg4ChfBNPKZEQd3WPNW1t/XndD/nP
 hIZ79d6wPq/GqbQfzBFvZtkROQWZMjCRK5CNTE8WNjn6Kxug0jd0fI394OCKxYrPkIEV
 pDTz1pkqCWOA4Mf9juO+KfpwpO9b/uG0wRnMv3UakGb4b9KvYZO86A22Nd4b1e2W/q+I
 MrhKE8OzPW1Q7ycT9HjNIzWgx+AraoebCkdUGoGbu5+y+1z6aeDXoRr1PrMEWHDZY3ns
 4Wmhus6rRyP5mHncw93o3itQIxpAcmq4rnpUM36C+QMI/lXRlDs41CWmRpnmJAwkq86+
 bN6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770187367; x=1770792167;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cIKuDVWrmwsDYfsEMIyqgWJoMDF4gy/wdB7kJv+fqRk=;
 b=RLeKg55WZp75E5NHwUw0fC9z6vgmUWnSPB1Iwc9KJr92KfxCdjd6UaklJzMl7+O51o
 5lsDO89a3dXKu6Xf+8W/voeEQG1pFiTAzVihn6/RZgTXPaQb+rwd5RqBgZbiCi2KxmDb
 d1j7/h89HLTcAFC7eiwousJHixc9cz3UbYmS3A+KyW4aKqwRjDHGMJbdka03rOGnFAjM
 7GHqrmVbROXiwV0GZ6uo4r5kjOjyNvmdXnuYi+GjZymAOIO/KepQVSYe1de5012mtu+v
 jwAwsS5reBrO/ZgS0PQRMhv1FkYX54awZYa8u2P5h7LUqIzM3DygUiyPjLpcseHYe+ON
 8c+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQn0OayH2MDMcm9g61Q4MQRC+/dFbV4OqULijVAUJjwyAC5bSYD91X2o35XOBwlFPR1VilOIzFfUHU@nongnu.org
X-Gm-Message-State: AOJu0YwbNAUDblbop9/rA4Y89LOTDDh6A66Et/uRtzqY3DMLw0S2gzkP
 pFEvRJPsYQMIEJwtwYT/8ZoB3OpVuYiPF4ZOwXi5cMcGRRhoh+zOL2/9ca4tyC0//d+XWqzSxPh
 7Hult26H2X/Yb9eDsVYU+mibcHT4jD3u4IeZyz6grBl7106uHy3Vmrhi2
X-Gm-Gg: AZuq6aLaNM5ZAAAF+4uJq4yv028FMsXJSCO0QSn5o0qg8/ug9Z5dJlNYWAFUzjwyED7
 gNSHao/LhBEzGTLA5u77hqER4SPEwMA+snEVO0FGj2/cFnvXz6XxQTi7GwpYp+KiXr6QYDifOmT
 Gx1KRNlhWKlg4eBZik7gBfs+i3ykVwLZILEOKyWoVU/yPsm5gJaZ/3AjzVgXSX7c0gMocjtkNNJ
 Cc0BOBuFjtIVYs75+SsKSNPTzda9nr6W9aS5StH/5BoyezHzqchOcQ3cbQjpjg64RVNzmv9iUUY
 nXmv7uxutxo/dTy50KQrnzSxvIlcr+cTFSi/93k18YTLABEZOY54x4GlDUAUZZhcTKt+6zrICBw
 O3M4c+FtSWyF5u1Bkf+kVcSsY77Rv8ZTu2Q==
X-Received: by 2002:a05:6000:2504:b0:436:4c1:ce9f with SMTP id
 ffacd0b85a97d-436113099a4mr8262688f8f.5.1770187366670; 
 Tue, 03 Feb 2026 22:42:46 -0800 (PST)
X-Received: by 2002:a05:6000:2504:b0:436:4c1:ce9f with SMTP id
 ffacd0b85a97d-436113099a4mr8262645f8f.5.1770187366009; 
 Tue, 03 Feb 2026 22:42:46 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e40b49sm4022102f8f.19.2026.02.03.22.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 22:42:45 -0800 (PST)
Date: Wed, 4 Feb 2026 01:42:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org,
 npiggin@gmail.com, fbarrat@linux.ibm.com,
 marcel.apfelbaum@gmail.com, cohuck@redhat.com, pbonzini@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, danielhb413@gmail.com
Subject: Re: [PATCH v2 4/9] pnv/phb4: Implement read-only and write-only bits
 of registers
Message-ID: <20260204001948-mutt-send-email-mst@kernel.org>
References: <20251230102156.886288-1-saif.abrar@linux.vnet.ibm.com>
 <20251230102156.886288-5-saif.abrar@linux.vnet.ibm.com>
 <20260204000148-mutt-send-email-mst@kernel.org>
 <20260204001123-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260204001123-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Feb 04, 2026 at 12:12:01AM -0500, Michael S. Tsirkin wrote:
> On Wed, Feb 04, 2026 at 12:04:20AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Dec 30, 2025 at 04:21:22AM -0600, Saif Abrar wrote:
> > > SW cannot write the read-only(RO) bits of a register
> > > and write-only(WO) bits of a register return 0 when read.
> > > 
> > > Added ro_mask[] for each register that defines which
> > > bits in that register are RO.
> > > When writing to a register, the RO-bits are not updated.
> > > 
> > > When reading a register, clear the WO bits and return the updated value.
> > > 
> > > Tested the registers PHB_DMA_SYNC, PHB_PCIE_HOTPLUG_STATUS, PHB_PCIE_LMR,
> > > PHB_PCIE_DLP_TRWCTL, PHB_LEM_ERROR_AND_MASK and PHB_LEM_ERROR_OR_MASK
> > > by writing all 1's and reading back the value.
> > > The WO bits in these registers should read back as 0.
> > > 
> > > Signed-off-by: Saif Abrar <saif.abrar@linux.vnet.ibm.com>
> > > Reviewed-by: Cédric Le Goater <clg@kaod.org>
> > 
> > causes a crash in boot-serial-test:
> > https://gitlab.com/mstredhat/qemu/-/jobs/12975819193
> 
> I forgot to say - with tci:
> 
>   ../configure --enable-tcg-interpreter --target-list=ppc64-softmmu                                                                      

triggered with tcg now, too.

  Core was generated by `/scm/qemu-bisect/build/qemu-system-ppc64 -qtest unix:/tmp/qtest-194326.sock -qtest-log /dev/null -chardev     
     socket,path=/tmp/qtest-194326.qmp,id=char0 -mon chardev=char0,mode=control -display none -audio none -run-with                      
    exit-with-parent=on -M powernv9 -no-shutdown -chardev file,id=serial0,path=/tmp/qtest-boot-serial-sVOZKK3 -serial                    
    chardev:serial0 -accel tcg -accel kvm -accel qtest'.                                                                                 
    Program terminated with signal SIGSEGV, Segmentation fault.                                                                          
    #0  0x000055fe6e84bcc8 in object_link_get_targetp (obj=0x55fe8ebbca10, lprop=0xf) at ../qom/object.c:1871                            
    1871            if (lprop->flags & OBJ_PROP_LINK_DIRECT) {                                                                           
    [Current thread is 1 (Thread 0x7f2716e774c0 (LWP 194336))]                                                                           
    warning: File "/scm/qemu/.gdbinit" auto-loading has been declined by your `auto-load safe-path' set to                               
    "$debugdir:$datadir/auto-load:/usr/lib/golang/src/runtime/runtime-gdb.py".                                                           
    To enable execution of this file add                                                                                                 
        add-auto-load-safe-path /scm/qemu/.gdbinit                                                                                       
    line to your configuration file "/home/mst/.config/gdb/gdbinit".                                                                     
    To completely disable this security protection add                                                                                   
        set auto-load safe-path /                                                                                                        
    line to your configuration file "/home/mst/.config/gdb/gdbinit".                                                                     
    For more information about this security protection see the                                                                          
    "Auto-loading safe path" section in the GDB manual.  E.g., run from the shell:                                                       
        info "(gdb)Auto-loading safe path"                                                                                               
    #0  0x000055fe6e84bcc8 in object_link_get_targetp (obj=0x55fe8ebbca10, lprop=0xf) at ../qom/object.c:1871                            
    #1  0x000055fe6e84c00f in object_set_link_property (obj=0x55fe8ebbca10, v=0x55fe8ebc81a0, name=0x55fe6ef9d504 "pec", opaque=0xf,     
     errp=0x7ffe749d2a00) at ../qom/object.c:1945                                                                                        
    #2  0x000055fe6e84aad7 in object_property_set (obj=0x55fe8ebbca10, name=0x55fe6ef9d504 "pec", v=0x55fe8ebc81a0,                      
    errp=0x7ffe749d2a00) at ../qom/object.c:1450                                                                                         
    #3  0x000055fe6e84fcc3 in object_property_set_qobject (obj=0x55fe8ebbca10, name=0x55fe6ef9d504 "pec", value=0x55fe8ebc8520,          
    errp=0x7ffe749d2a00) at ../qom/qom-qobject.c:28                                                                                      
    #4  0x000055fe6e84ab7b in object_property_set_str (obj=0x55fe8ebbca10, name=0x55fe6ef9d504 "pec", value=0x55fe8ebbc8e0               
    "/machine/chip[0]/pec[0]", errp=0x7ffe749d2a00) at ../qom/object.c:1458                                                              
    #5  0x000055fe6e84ad30 in object_property_set_link (obj=0x55fe8ebbca10, name=0x55fe6ef9d504 "pec", value=0x55fe8e654330,             
    errp=0x7ffe749d2a00) at ../qom/object.c:1495                                                                                         
    #6  0x000055fe6e7fb1ff in pnv_phb_realize (dev=0x55fe8ebbb960, errp=0x7ffe749d2a00) at ../hw/pci-host/pnv_phb.c:156                  
    #7  0x000055fe6e8435be in device_set_realized (obj=0x55fe8ebbb960, value=true, errp=0x7ffe749d2d60) at ../hw/core/qdev.c:523         
    #8  0x000055fe6e84d060 in property_set_bool (obj=0x55fe8ebbb960, v=0x55fe8e70db20, name=0x55fe6efb2979 "realized",                   
    opaque=0x55fe8e2595f0, errp=0x7ffe749d2d60) at ../qom/object.c:2376                                                                  
    #9  0x000055fe6e84aad7 in object_property_set (obj=0x55fe8ebbb960, name=0x55fe6efb2979 "realized", v=0x55fe8e70db20,                 
    errp=0x7ffe749d2d60) at ../qom/object.c:1450                                                                                         
    #10 0x000055fe6e84fcc3 in object_property_set_qobject (obj=0x55fe8ebbb960, name=0x55fe6efb2979 "realized", value=0x55fe8ebbc860,     
     errp=0x7ffe749d2d60) at ../qom/qom-qobject.c:28                                                                                     
    #11 0x000055fe6e84ae8a in object_property_set_bool (obj=0x55fe8ebbb960, name=0x55fe6efb2979 "realized", value=true,                  
    errp=0x7ffe749d2d60) at ../qom/object.c:1520                                                                                         
    #12 0x000055fe6e842c6b in qdev_realize (dev=0x55fe8ebbb960, bus=0x55fe8e6164d0, errp=0x7ffe749d2d60) at ../hw/core/qdev.c:276        
    #13 0x000055fe6e1ee440 in sysbus_realize (dev=0x55fe8ebbb960, errp=0x7ffe749d2d60) at ../hw/core/sysbus.c:249                        
    #14 0x000055fe6e7f9901 in pnv_pec_default_phb_realize (pec=0x55fe8e654330, stack_no=0, errp=0x7ffe749d2d60) at                       
    ../hw/pci-host/pnv_phb4_pec.c:194                                                                                                    
    #15 0x000055fe6e7f9bc0 in pnv_pec_realize (dev=0x55fe8e654330, errp=0x7ffe749d2d60) at ../hw/pci-host/pnv_phb4_pec.c:258             
    #16 0x000055fe6e8435be in device_set_realized (obj=0x55fe8e654330, value=true, errp=0x7ffe749d2fe8) at ../hw/core/qdev.c:523         
    #17 0x000055fe6e84d060 in property_set_bool (obj=0x55fe8e654330, v=0x55fe8e63ea90, name=0x55fe6efb2979 "realized",                   
    opaque=0x55fe8e2595f0, errp=0x7ffe749d2fe8) at ../qom/object.c:2376                                                                  
    #18 0x000055fe6e84aad7 in object_property_set (obj=0x55fe8e654330, name=0x55fe6efb2979 "realized", v=0x55fe8e63ea90,                 
    errp=0x7ffe749d2fe8) at ../qom/object.c:1450                                                                                         
    #19 0x000055fe6e84fcc3 in object_property_set_qobject (obj=0x55fe8e654330, name=0x55fe6efb2979 "realized", value=0x55fe8ebbb0f0,     
     errp=0x7ffe749d2fe8) at ../qom/qom-qobject.c:28                                                                                     
    #20 0x000055fe6e84ae8a in object_property_set_bool (obj=0x55fe8e654330, name=0x55fe6efb2979 "realized", value=true,                  
    errp=0x7ffe749d2fe8) at ../qom/object.c:1520                                                                                         
    #21 0x000055fe6e842c6b in qdev_realize (dev=0x55fe8e654330, bus=0x0, errp=0x7ffe749d2fe8) at ../hw/core/qdev.c:276                   
    #22 0x000055fe6e676fef in pnv_chip_power9_pec_realize (chip=0x55fe8e64e4f0, errp=0x7ffe749d2fe8) at ../hw/ppc/pnv.c:1892             
    #23 0x000055fe6e677b1b in pnv_chip_power9_realize (dev=0x55fe8e64e4f0, errp=0x7ffe749d3080) at ../hw/ppc/pnv.c:2108                  
    #24 0x000055fe6e8435be in device_set_realized (obj=0x55fe8e64e4f0, value=true, errp=0x7ffe749d3190) at ../hw/core/qdev.c:523         
    #25 0x000055fe6e84d060 in property_set_bool (obj=0x55fe8e64e4f0, v=0x55fe8e623cf0, name=0x55fe6efb2979 "realized",                   
    opaque=0x55fe8e2595f0, errp=0x7ffe749d3190) at ../qom/object.c:2376                                                                  
    #26 0x000055fe6e84aad7 in object_property_set (obj=0x55fe8e64e4f0, name=0x55fe6efb2979 "realized", v=0x55fe8e623cf0,                 
    errp=0x7ffe749d3190) at ../qom/object.c:1450                                                                                         
    #27 0x000055fe6e84fcc3 in object_property_set_qobject (obj=0x55fe8e64e4f0, name=0x55fe6efb2979 "realized", value=0x55fe8e63eb90,     
     errp=0x55fe6f599380 <error_fatal>) at ../qom/qom-qobject.c:28                                                                       
    #28 0x000055fe6e84ae8a in object_property_set_bool (obj=0x55fe8e64e4f0, name=0x55fe6efb2979 "realized", value=true,                  
    errp=0x55fe6f599380 <error_fatal>) at ../qom/object.c:1520                                                                           
    #29 0x000055fe6e842c6b in qdev_realize (dev=0x55fe8e64e4f0, bus=0x55fe8e6164d0, errp=0x55fe6f599380 <error_fatal>) at                
    ../hw/core/qdev.c:276                                                                                                                
    #30 0x000055fe6e842ca4 in qdev_realize_and_unref (dev=0x55fe8e64e4f0, bus=0x55fe8e6164d0, errp=0x55fe6f599380 <error_fatal>) at      
    ../hw/core/qdev.c:283                                                                                                                
    #31 0x000055fe6e1ee488 in sysbus_realize_and_unref (dev=0x55fe8e64e4f0, errp=0x55fe6f599380 <error_fatal>) at                        
    ../hw/core/sysbus.c:254                                                                                                              
    #32 0x000055fe6e675245 in pnv_init (machine=0x55fe8e615c80) at ../hw/ppc/pnv.c:1221                                                  
    #33 0x000055fe6e1e62de in machine_run_board_init (machine=0x55fe8e615c80, mem_path=0x0, errp=0x7ffe749d3420) at                      
    ../hw/core/machine.c:1747                                                                                                            
    #34 0x000055fe6e44f235 in qemu_init_board () at ../system/vl.c:2715                                                                  
    #35 0x000055fe6e44f5c8 in qmp_x_exit_preconfig (errp=0x55fe6f599380 <error_fatal>) at ../system/vl.c:2809                            
    #36 0x000055fe6e452a22 in qemu_init (argc=28, argv=0x7ffe749d37d8) at ../system/vl.c:3849                                            
    #37 0x000055fe6e99bb52 in main (argc=28, argv=0x7ffe749d37d8) at ../system/main.c:71                                                 
     


Looking at it:

    #0  0x000055fe6e84bcc8 in object_link_get_targetp (obj=0x55fe8ebbca10, lprop=0xf) at ../qom/object.c:1871                            
    #1  0x000055fe6e84c00f in object_set_link_property (obj=0x55fe8ebbca10, v=0x55fe8ebc81a0, name=0x55fe6ef9d504 "pec", opaque=0xf,     
     errp=0x7ffe749d2a00) at ../qom/object.c:1945                                                                                        
              

  The opaque=0xf (15) is being passed as lprop but it should be a pointer to an ObjectLinkProperty.

Could be this:
  -OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4, PNV_PHB4)                                                                                         
  +OBJECT_DECLARE_TYPE(PnvPHB4, PnvPHB4Class, PNV_PHB4)                                                                                  

The following seems to fix it:

$ git diff
diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
index 48caba9e79..0eb1e7c2bf 100644
--- a/hw/pci-host/pnv_phb4.c
+++ b/hw/pci-host/pnv_phb4.c
@@ -1998,6 +1998,7 @@ static const TypeInfo pnv_phb4_type_info = {
     .parent        = TYPE_DEVICE,
     .instance_init = pnv_phb4_instance_init,
     .instance_size = sizeof(PnvPHB4),
+    .class_size    = sizeof(PnvPHB4Class),
     .class_init    = pnv_phb4_class_init,
     .interfaces = (const InterfaceInfo[]) {
             { TYPE_XIVE_NOTIFIER },


without .class_size, QOM will allocate sizeof(DeviceClass) and heap is
corrupted.

> 
> > bisect script:
> > 
> > #!/bin/bash                                                                                                                            
> > cd /scm/qemu-bisect/build                                                                                                              
> > make -j$(nproc) || exit 125                                                                                                            
> > ninja tests/qtest/boot-serial-test || exit 125                                                                                         
> > QTEST_QEMU_BINARY=./qemu-system-ppc64 timeout 60 ./tests/qtest/boot-serial-test -p /ppc64/boot-serial/powernv9 && exit 0 || exit 1     
> > 
> > 
> > > ---
> > > v1 -> v2: New PnvPHB4Class to hold each register's RO mask.
> > > 
> > >  hw/pci-host/pnv_phb4.c              | 78 ++++++++++++++++++++++++++---
> > >  include/hw/pci-host/pnv_phb4.h      | 13 ++++-
> > >  include/hw/pci-host/pnv_phb4_regs.h | 20 ++++++--
> > >  tests/qtest/pnv-phb4-test.c         | 60 +++++++++++++++++++++-
> > >  4 files changed, 157 insertions(+), 14 deletions(-)
> > > 
> > > diff --git a/hw/pci-host/pnv_phb4.c b/hw/pci-host/pnv_phb4.c
> > > index 70f5af21fa..48caba9e79 100644
> > > --- a/hw/pci-host/pnv_phb4.c
> > > +++ b/hw/pci-host/pnv_phb4.c
> > > @@ -707,6 +707,11 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
> > >          return;
> > >      }
> > >  
> > > +    /* Update 'val' according to the register's RO-mask */
> > > +    PnvPHB4Class *k = PNV_PHB4_GET_CLASS(phb);
> > > +    val = (phb->regs[off >> 3] & k->ro_mask[off >> 3]) |
> > > +                                            (val & ~(k->ro_mask[off >> 3]));
> > > +
> > >      /* Record whether it changed */
> > >      changed = phb->regs[off >> 3] != val;
> > >  
> > > @@ -781,7 +786,7 @@ static void pnv_phb4_reg_write(void *opaque, hwaddr off, uint64_t val,
> > >      case PHB_TCE_TAG_ENABLE:
> > >      case PHB_INT_NOTIFY_ADDR:
> > >      case PHB_INT_NOTIFY_INDEX:
> > > -    case PHB_DMARD_SYNC:
> > > +    case PHB_DMA_SYNC:
> > >         break;
> > >  
> > >      /* Noise on anything else */
> > > @@ -819,7 +824,7 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
> > >      case PHB_VERSION:
> > >          return PNV_PHB4_PEC_GET_CLASS(phb->pec)->version;
> > >  
> > > -        /* Read-only */
> > > +    /* Read-only */
> > >      case PHB_PHB4_GEN_CAP:
> > >          return 0xe4b8000000000000ull;
> > >      case PHB_PHB4_TCE_CAP:
> > > @@ -829,18 +834,49 @@ static uint64_t pnv_phb4_reg_read(void *opaque, hwaddr off, unsigned size)
> > >      case PHB_PHB4_EEH_CAP:
> > >          return phb->big_phb ? 0x2000000000000000ull : 0x1000000000000000ull;
> > >  
> > > +    /* Write-only, read will return zeros */
> > > +    case PHB_LEM_ERROR_AND_MASK:
> > > +    case PHB_LEM_ERROR_OR_MASK:
> > > +        return 0;
> > > +    case PHB_PCIE_DLP_TRWCTL:
> > > +        val &= ~PHB_PCIE_DLP_TRWCTL_WREN;
> > > +        return val;
> > >      /* IODA table accesses */
> > >      case PHB_IODA_DATA0:
> > >          return pnv_phb4_ioda_read(phb);
> > >  
> > > +    /*
> > > +     * DMA sync: make it look like it's complete,
> > > +     *           clear write-only read/write start sync bits.
> > > +     */
> > > +    case PHB_DMA_SYNC:
> > > +        val = PHB_DMA_SYNC_RD_COMPLETE |
> > > +            ~(PHB_DMA_SYNC_RD_START | PHB_DMA_SYNC_WR_START);
> > > +        return val;
> > > +
> > > +    /*
> > > +     * PCI-E Stack registers
> > > +     */
> > > +    case PHB_PCIE_SCR:
> > > +        val |= PHB_PCIE_SCR_PLW_X16; /* RO bit */
> > > +        break;
> > > +
> > >      /* Link training always appears trained */
> > >      case PHB_PCIE_DLP_TRAIN_CTL:
> > >          /* TODO: Do something sensible with speed ? */
> > > -        return PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
> > > +        val |= PHB_PCIE_DLP_INBAND_PRESENCE | PHB_PCIE_DLP_TL_LINKACT;
> > > +        return val;
> > > +
> > > +    case PHB_PCIE_HOTPLUG_STATUS:
> > > +        /* Clear write-only bit */
> > > +        val &= ~PHB_PCIE_HPSTAT_RESAMPLE;
> > > +        return val;
> > >  
> > > -    /* DMA read sync: make it look like it's complete */
> > > -    case PHB_DMARD_SYNC:
> > > -        return PHB_DMARD_SYNC_COMPLETE;
> > > +    /* Link Management Register */
> > > +    case PHB_PCIE_LMR:
> > > +        /* These write-only bits always read as 0 */
> > > +        val &= ~(PHB_PCIE_LMR_CHANGELW | PHB_PCIE_LMR_RETRAINLINK);
> > > +        return val;
> > >  
> > >      /* Silent simple reads */
> > >      case PHB_LSI_SOURCE_ID:
> > > @@ -1685,6 +1721,32 @@ static PCIIOMMUOps pnv_phb4_iommu_ops = {
> > >      .get_address_space = pnv_phb4_dma_iommu,
> > >  };
> > >  
> > > +static void pnv_phb4_ro_mask_init(PnvPHB4 *phb)
> > > +{
> > > +    PnvPHB4Class *phb4c = PNV_PHB4_GET_CLASS(phb);
> > > +
> > > +    /*
> > > +     * Set register specific RO-masks
> > > +     */
> > > +
> > > +    /* PBL - Error Injection Register (0x1910) */
> > > +    phb4c->ro_mask[PHB_PBL_ERR_INJECT >> 3] =
> > > +        PPC_BITMASK(0, 23) | PPC_BITMASK(28, 35) | PPC_BIT(38) | PPC_BIT(46) |
> > > +        PPC_BITMASK(49, 51) | PPC_BITMASK(55, 63);
> > > +
> > > +    /* Reserved bits[60:63] */
> > > +    phb4c->ro_mask[PHB_TXE_ERR_LEM_ENABLE >> 3] =
> > > +    phb4c->ro_mask[PHB_TXE_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(60, 63);
> > > +    /* Reserved bits[36:63] */
> > > +    phb4c->ro_mask[PHB_RXE_TCE_ERR_LEM_ENABLE >> 3] =
> > > +    phb4c->ro_mask[PHB_RXE_TCE_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(36, 63);
> > > +    /* Reserved bits[40:63] */
> > > +    phb4c->ro_mask[PHB_ERR_LEM_ENABLE >> 3] =
> > > +    phb4c->ro_mask[PHB_ERR_AIB_FENCE_ENABLE >> 3] = PPC_BITMASK(40, 63);
> > > +
> > > +    /* TODO: Add more RO-masks as regs are implemented in the model */
> > > +}
> > > +
> > >  static void pnv_phb4_err_reg_reset(PnvPHB4 *phb)
> > >  {
> > >      STICKY_RST(PHB_ERR_STATUS,       0, PPC_BITMASK(0, 33));
> > > @@ -1743,6 +1805,7 @@ static void pnv_phb4_reset(Object *obj, ResetType type)
> > >      pnv_phb4_err_reg_reset(phb);
> > >      pnv_phb4_pcie_stack_reg_reset(phb);
> > >      pnv_phb4_regb_err_reg_reset(phb);
> > > +    phb->regs[PHB_PCIE_CRESET >> 3] = 0xE000000000000000;
> > >  }
> > >  
> > >  static void pnv_phb4_instance_init(Object *obj)
> > > @@ -1753,6 +1816,9 @@ static void pnv_phb4_instance_init(Object *obj)
> > >  
> > >      /* XIVE interrupt source object */
> > >      object_initialize_child(obj, "source", &phb->xsrc, TYPE_XIVE_SOURCE);
> > > +
> > > +    /* Initialize RO-mask of registers */
> > > +    pnv_phb4_ro_mask_init(phb);
> > >  }
> > >  
> > >  void pnv_phb4_bus_init(DeviceState *dev, PnvPHB4 *phb)
> > > diff --git a/include/hw/pci-host/pnv_phb4.h b/include/hw/pci-host/pnv_phb4.h
> > > index 47a5c3edf5..bea0684724 100644
> > > --- a/include/hw/pci-host/pnv_phb4.h
> > > +++ b/include/hw/pci-host/pnv_phb4.h
> > > @@ -19,7 +19,7 @@
> > >  
> > >  
> > >  #define TYPE_PNV_PHB4 "pnv-phb4"
> > > -OBJECT_DECLARE_SIMPLE_TYPE(PnvPHB4, PNV_PHB4)
> > > +OBJECT_DECLARE_TYPE(PnvPHB4, PnvPHB4Class, PNV_PHB4)
> > >  
> > >  typedef struct PnvPhb4PecStack PnvPhb4PecStack;
> > >  
> > > @@ -156,6 +156,17 @@ struct PnvPHB4 {
> > >      QLIST_HEAD(, PnvPhb4DMASpace) dma_spaces;
> > >  };
> > >  
> > > +typedef struct PnvPHB4Class {
> > > +    DeviceClass parent_class;
> > > +
> > > +    /*
> > > +     * Read-only bitmask for registers
> > > +     * Bit value: 1 => RO bit
> > > +     *            0 => RW bit
> > > +     */
> > > +    uint64_t ro_mask[PNV_PHB4_NUM_REGS];
> > > +} PnvPHB4Class;
> > > +
> > >  void pnv_phb4_pic_print_info(PnvPHB4 *phb, GString *buf);
> > >  int pnv_phb4_pec_get_phb_id(PnvPhb4PecState *pec, int stack_index);
> > >  PnvPhb4PecState *pnv_pec_add_phb(PnvChip *chip, PnvPHB *phb, Error **errp);
> > > diff --git a/include/hw/pci-host/pnv_phb4_regs.h b/include/hw/pci-host/pnv_phb4_regs.h
> > > index df5e86d29a..dfd0e01d1e 100644
> > > --- a/include/hw/pci-host/pnv_phb4_regs.h
> > > +++ b/include/hw/pci-host/pnv_phb4_regs.h
> > > @@ -180,9 +180,11 @@
> > >  #define PHB_M64_AOMASK                  0x1d0
> > >  #define PHB_M64_UPPER_BITS              0x1f0
> > >  #define PHB_NXLATE_PREFIX               0x1f8
> > > -#define PHB_DMARD_SYNC                  0x200
> > > -#define   PHB_DMARD_SYNC_START          PPC_BIT(0)
> > > -#define   PHB_DMARD_SYNC_COMPLETE       PPC_BIT(1)
> > > +#define PHB_DMA_SYNC                    0x200
> > > +#define   PHB_DMA_SYNC_RD_START         PPC_BIT(0)
> > > +#define   PHB_DMA_SYNC_RD_COMPLETE      PPC_BIT(1)
> > > +#define   PHB_DMA_SYNC_WR_START         PPC_BIT(2)
> > > +#define   PHB_DMA_SYNC_WR_COMPLETE      PPC_BIT(3)
> > >  #define PHB_RTC_INVALIDATE              0x208
> > >  #define   PHB_RTC_INVALIDATE_ALL        PPC_BIT(0)
> > >  #define   PHB_RTC_INVALIDATE_RID        PPC_BITMASK(16, 31)
> > > @@ -370,6 +372,7 @@
> > >  #define P32_CAP                                 0x228
> > >  #define P32_CTL                                 0x22C
> > >  #define P32_STAT                                0x230
> > > +
> > >  /* PHB4 REGB registers */
> > >  
> > >  /* PBL core */
> > > @@ -395,8 +398,8 @@
> > >  #define PHB_PCIE_SCR                    0x1A00
> > >  #define   PHB_PCIE_SCR_SLOT_CAP         PPC_BIT(15)
> > >  #define   PHB_PCIE_SCR_MAXLINKSPEED     PPC_BITMASK(32, 35)
> > > +#define   PHB_PCIE_SCR_PLW_X16          PPC_BIT(41) /* x16 */
> > >  #define PHB_PCIE_BNR                    0x1A08
> > > -
> > >  #define PHB_PCIE_CRESET                 0x1A10
> > >  #define   PHB_PCIE_CRESET_CFG_CORE      PPC_BIT(0)
> > >  #define   PHB_PCIE_CRESET_TLDLP         PPC_BIT(1)
> > > @@ -405,7 +408,14 @@
> > >  #define   PHB_PCIE_CRESET_PIPE_N        PPC_BIT(4)
> > >  #define   PHB_PCIE_CRESET_REFCLK_N      PPC_BIT(8)
> > >  #define PHB_PCIE_HOTPLUG_STATUS         0x1A20
> > > +#define   PHB_PCIE_HPSTAT_SIMDIAG       PPC_BIT(3)
> > > +#define   PHB_PCIE_HPSTAT_RESAMPLE      PPC_BIT(9)
> > >  #define   PHB_PCIE_HPSTAT_PRESENCE      PPC_BIT(10)
> > > +#define   PHB_PCIE_HPSTAT_LINKACTIVE    PPC_BIT(12)
> > > +#define PHB_PCIE_LMR                    0x1A30
> > > +#define   PHB_PCIE_LMR_CHANGELW         PPC_BIT(0)
> > > +#define   PHB_PCIE_LMR_RETRAINLINK      PPC_BIT(1)
> > > +#define   PHB_PCIE_LMR_LINKACTIVE       PPC_BIT(8)
> > >  
> > >  #define PHB_PCIE_DLP_TRAIN_CTL          0x1A40
> > >  #define   PHB_PCIE_DLP_LINK_WIDTH       PPC_BITMASK(30, 35)
> > > @@ -433,7 +443,7 @@
> > >  
> > >  #define PHB_PCIE_DLP_TRWCTL             0x1A80
> > >  #define   PHB_PCIE_DLP_TRWCTL_EN        PPC_BIT(0)
> > > -
> > > +#define   PHB_PCIE_DLP_TRWCTL_WREN      PPC_BIT(1)
> > >  #define PHB_PCIE_DLP_ERRLOG1            0x1AA0
> > >  #define PHB_PCIE_DLP_ERRLOG2            0x1AA8
> > >  #define PHB_PCIE_DLP_ERR_STATUS         0x1AB0
> > > diff --git a/tests/qtest/pnv-phb4-test.c b/tests/qtest/pnv-phb4-test.c
> > > index f186efaf0d..841306ae3f 100644
> > > --- a/tests/qtest/pnv-phb4-test.c
> > > +++ b/tests/qtest/pnv-phb4-test.c
> > > @@ -73,7 +73,8 @@ static void phb4_sticky_rst_test(QTestState *qts)
> > >       * Sticky reset test of PHB_PBL_ERR_STATUS.
> > >       *
> > >       * Write all 1's to reg PHB_PBL_ERR_INJECT.
> > > -     * Updated value will be copied to reg PHB_PBL_ERR_STATUS.
> > > +     * RO-only bits will not be written and
> > > +     * updated value will be copied to reg PHB_PBL_ERR_STATUS.
> > >       *
> > >       * Reset PBL core by setting PHB_PCIE_CRESET_PBL in reg PHB_PCIE_CRESET.
> > >       * Verify the sticky bits are still set.
> > > @@ -81,7 +82,59 @@ static void phb4_sticky_rst_test(QTestState *qts)
> > >      phb4_xscom_write(PHB_PBL_ERR_INJECT, PPC_BITMASK(0, 63));
> > >      phb4_xscom_write(PHB_PCIE_CRESET, PHB_PCIE_CRESET_PBL); /*Reset*/
> > >      val = phb4_xscom_read(PHB_PBL_ERR_STATUS);
> > > -    g_assert_cmpuint(val, ==, (PPC_BITMASK(0, 9) | PPC_BITMASK(12, 63)));
> > > +    g_assert_cmpuint(val, ==, 0xF00DFD8E00);
> > > +}
> > > +
> > > +/* Check that write-only bits/regs return 0 when read */
> > > +static void phb4_writeonly_read_test(QTestState *qts)
> > > +{
> > > +    uint64_t val;
> > > +
> > > +    /*
> > > +     * Set all bits of PHB_DMA_SYNC,
> > > +     * bits 0 and 2 are write-only and should be read as 0.
> > > +     */
> > > +    phb4_xscom_write(PHB_DMA_SYNC, PPC_BITMASK(0, 63));
> > > +    val = phb4_xscom_read(PHB_DMA_SYNC);
> > > +    g_assert_cmpuint(val & PPC_BIT(0), ==, 0x0);
> > > +    g_assert_cmpuint(val & PPC_BIT(2), ==, 0x0);
> > > +
> > > +    /*
> > > +     * Set all bits of PHB_PCIE_HOTPLUG_STATUS,
> > > +     * bit 9 is write-only and should be read as 0.
> > > +     */
> > > +    phb4_xscom_write(PHB_PCIE_HOTPLUG_STATUS, PPC_BITMASK(0, 63));
> > > +    val = phb4_xscom_read(PHB_PCIE_HOTPLUG_STATUS);
> > > +    g_assert_cmpuint(val & PPC_BIT(9), ==, 0x0);
> > > +
> > > +    /*
> > > +     * Set all bits of PHB_PCIE_LMR,
> > > +     * bits 0 and 1 are write-only and should be read as 0.
> > > +     */
> > > +    phb4_xscom_write(PHB_PCIE_LMR, PPC_BITMASK(0, 63));
> > > +    val = phb4_xscom_read(PHB_PCIE_LMR);
> > > +    g_assert_cmpuint(val & PPC_BIT(0), ==, 0x0);
> > > +    g_assert_cmpuint(val & PPC_BIT(1), ==, 0x0);
> > > +
> > > +    /*
> > > +     * Set all bits of PHB_PCIE_DLP_TRWCTL,
> > > +     * write-only bit-1 should be read as 0.
> > > +     */
> > > +    phb4_xscom_write(PHB_PCIE_DLP_TRWCTL, PPC_BITMASK(0, 63));
> > > +    val = phb4_xscom_read(PHB_PCIE_DLP_TRWCTL);
> > > +    g_assert_cmpuint(val & PPC_BIT(1), ==, 0x0);
> > > +
> > > +    /*
> > > +     * Set all bits of PHB_LEM_ERROR_AND_MASK, PHB_LEM_ERROR_OR_MASK,
> > > +     * both regs are write-only and should be read as 0.
> > > +     */
> > > +    phb4_xscom_write(PHB_LEM_ERROR_AND_MASK, PPC_BITMASK(0, 63));
> > > +    val = phb4_xscom_read(PHB_LEM_ERROR_AND_MASK);
> > > +    g_assert_cmpuint(val, ==, 0x0);
> > > +
> > > +    phb4_xscom_write(PHB_LEM_ERROR_OR_MASK, PPC_BITMASK(0, 63));
> > > +    val = phb4_xscom_read(PHB_LEM_ERROR_OR_MASK);
> > > +    g_assert_cmpuint(val, ==, 0x0);
> > >  }
> > >  
> > >  static void phb4_tests(void)
> > > @@ -96,6 +149,9 @@ static void phb4_tests(void)
> > >      /* Check sticky reset of a register */
> > >      phb4_sticky_rst_test(qts);
> > >  
> > > +    /* Check write-only logic */
> > > +    phb4_writeonly_read_test(qts);
> > > +
> > >      qtest_quit(qts);
> > >  }
> > >  
> > > -- 
> > > 2.47.3


