Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F892C71135
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 10:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ1Bp-0004lD-SQ; Fri, 13 Jun 2025 05:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uQ1Bn-0004ku-Kx
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 05:59:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uQ1Bj-0001kZ-R1
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 05:59:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749808746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0zA/p9XBqms49VcXc5BvkOgIQcG6RgIcjgZGyykQWbs=;
 b=YQW0FINW44S67Fjk6wiFuHCy4JTPRJHtENL05hSKVKNBjow54bfbjSGNpWRAGFfmD20dPp
 gdtBn3E136J7aBZSsoD/GTjvj9Tvie/NktJzye0JlQW5JQoX1Ldg5X4pqibforSVegOuje
 mdiX7awPVBXR2W8AlebbPx3Tqb9FoDc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-xMChQoLNMWmrd8OHtzOKJQ-1; Fri, 13 Jun 2025 05:59:04 -0400
X-MC-Unique: xMChQoLNMWmrd8OHtzOKJQ-1
X-Mimecast-MFC-AGG-ID: xMChQoLNMWmrd8OHtzOKJQ_1749808743
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a50816ccc6so1002490f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 02:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749808743; x=1750413543;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0zA/p9XBqms49VcXc5BvkOgIQcG6RgIcjgZGyykQWbs=;
 b=dPITP5L0vMsCp+RhPf2rlQma0vlciILqmkOsaF4p3UnJo5l73VTedNlo1AV2zfzY/n
 duy6whEQEXdvg+/j5OMTi9TDqLxeGoiCtgdHrYIN9FdF7/HCQJ8HSOOGMRTGtcB85KaJ
 G1Sdr1pXI74P6w05DORbDFhOKCEaR9sD9VqBeGPd2Hb0LxWS8VVBOo+gO0K88M6OxJ/H
 1u+k2SuLZ5IZrh9V4NGM7pW+bDqpKBhFHrnSiqXYPlR4v4dRM9WLSa0Nwo5Q+LrGOiox
 xybsdmJ2L0XXZW8IGA48ukR5+BZ2VgFW8NaU2YWyP91H7kNXYEbg/oiiJPy95/lw7VBv
 2qzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgGNs6s6XpMhz+bAWtn7K/jS5MqB7JGlAJ5DbMrsbWpCkObL/tzqXpf0bXowopqqmO+VhU7VEmbRIg@nongnu.org
X-Gm-Message-State: AOJu0YwVydi5rr6qCEerAjX/6VNtQUHoCtmRgC6Gx/ujdmgMDN/iLgCB
 xV+iTwLWS/Sreyl2Kj339wzXU/HDJRSlAAgVaeD30YYwhRYB8gv1ZuxRLagQoVWUVFefdrpTL/2
 m1d1aiQFsrSC7hBKmmp6ChUuetk/yel/wIFBXYRgX+sNtWhsaSQtv4ozy
X-Gm-Gg: ASbGncu8zxU2RzWbZXwr8a5R/2KO9UR7ET7sqH6z61FdkS5t4H3xsduxmTo97aD3Q+g
 Az4BcpwV25IXAGZJnkSBjshjUiznUU5XdsHZy/Bk12flt+2xmXsNXhLjc3oKx0zQn228wfm4O5F
 YbGzY+g16iFli7oXDaTAoQ6ayatsdP1s8triUc6tYdr7eoti8aFPHnUmwwTabUwSmEN9DSBXexC
 dN532qtA7QhzbYTNlL2VwB1V+G2gqgLnqrJ5Ivwa78F7KJ8dW84ph6wcuZ2QK1hMEC9Mb1WPovu
 LFI3MNSTZH+cTNxFsHeIgpZCMC8bc+hQEy9hzM6GRDUwWrO3oFSA4JUM9jnE+w==
X-Received: by 2002:a05:6000:2c13:b0:3a4:f71e:d2e with SMTP id
 ffacd0b85a97d-3a56875ddf1mr2263199f8f.56.1749808743021; 
 Fri, 13 Jun 2025 02:59:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7s6J4dsvwQ8sxrGdv+5Io3EH2FxMxuXyb1/JuX5cGOUi/Z/XvYSf66UHpScAIRoMnhwpbYA==
X-Received: by 2002:a05:6000:2c13:b0:3a4:f71e:d2e with SMTP id
 ffacd0b85a97d-3a56875ddf1mr2263175f8f.56.1749808742599; 
 Fri, 13 Jun 2025 02:59:02 -0700 (PDT)
Received: from [192.168.0.4] (ltea-047-064-114-027.pools.arcor-ip.net.
 [47.64.114.27]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568b798d3sm1845072f8f.100.2025.06.13.02.59.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Jun 2025 02:59:01 -0700 (PDT)
Message-ID: <7e228759-2fea-48e9-a604-4dadb9882f13@redhat.com>
Date: Fri, 13 Jun 2025 11:59:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to QOM
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>,
 qemu-s390x mailing list <qemu-s390x@nongnu.org>
Cc: Daniel Berrange <berrange@redhat.com>,
 qemu-devel mailing list <qemu-devel@nongnu.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Hendrik Brueckner <brueckner@linux.ibm.com>,
 Sebastian Mitterle <smitterl@redhat.com>, Boqiao Fu <bfu@redhat.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-3-shalini@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250603135655.595602-3-shalini@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 03/06/2025 15.56, Shalini Chellathurai Saroja wrote:
> Add Control-Program Identification (CPI) data to the QEMU Object
> Model (QOM), along with the timestamp in which the data was received
> as shown below.
...
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 5373e1368c..1f2db68032 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -2279,3 +2279,61 @@
>   # Since: 1.2
>   ##
>   { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
> +
> +##
> +# @S390ControlProgramId:
> +#
> +# Control-program identifiers provide data about the guest operating system.
> +# The control-program identifiers are: system type, system name, system level
> +# and sysplex name.
> +#
> +# In Linux, all the control-program identifiers are user configurable. The
> +# system type, system name, and sysplex name use EBCDIC characters from
> +# this set: capital A-Z, 0-9, $, @, #, and blank.  In Linux, the system type,
> +# system name and sysplex name are arbitrary free-form texts.
> +#
> +# In Linux, the 8-byte hexadecimal system-level has the format
> +# 0x<a><b><cc><dd><eeee><ff><gg><hh>, where:
> +# <a>: is one hexadecimal byte, its most significant bit indicates hypervisor
> +# use

  Hi Shalini!

While testing the patches, the above description caused some headache for 
me, but I think it's simply typo here: This is not a hexadecimal byte, it's 
just a nibble / 4-bit digit for this <a>, right? Could you please fix the 
description in the next version of the patch series, please?

  Thanks,
   Thomas


> +# <b>: is one digit that represents Linux distributions as follows
> +# 0: generic Linux
> +# 1: Red Hat Enterprise Linux
> +# 2: SUSE Linux Enterprise Server
> +# 3: Canonical Ubuntu
> +# 4: Fedora
> +# 5: openSUSE Leap
> +# 6: Debian GNU/Linux
> +# 7: Red Hat Enterprise Linux CoreOS
> +# <cc>: are two digits for a distribution-specific encoding of the major version
> +# of the distribution
> +# <dd>: are two digits for a distribution-specific encoding of the minor version
> +# of the distribution
> +# <eeee>: are four digits for the patch level of the distribution
> +# <ff>: are two digits for the major version of the kernel
> +# <gg>: are two digits for the minor version of the kernel
> +# <hh>: are two digits for the stable version of the kernel
> +# (e.g. 74872343805430528, when converted to hex is 0x010a000000060b00). On
> +# machines prior to z16, some of the values are not available to display.
> +#
> +# Sysplex refers to a cluster of logical partitions that communicates and
> +# co-operates with each other.
> +#
> +# @system-type: operating system (e.g. "LINUX   ")
> +#
> +# @system-name: user configurable name of the VM (e.g. "TESTVM  ")
> +#
> +# @system-level: distribution and kernel version in Linux
> +#
> +# @sysplex-name: sysplex which the VM belongs to, if any (e.g. "PLEX ")
> +#
> +# @timestamp: latest update of CPI data in nanoseconds since the UNIX EPOCH
> +#
> +# Since: 10.1
> +##
> +{ 'struct': 'S390ControlProgramId', 'data': {
> +     'system-type': 'str',
> +     'system-name': 'str',
> +     'system-level': 'uint64',
> +     'sysplex-name': 'str',
> +     'timestamp': 'uint64' } }


