Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DFDFD877F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 14:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Vla-0003U6-E2; Tue, 17 Mar 2026 10:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w2VlW-0003TM-E0
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:51:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1w2VlT-00046J-O8
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 10:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773759082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2Lo+bTFS2sTxr9F0hctE8ClsSTbh46CI1nFaCZ2kJ/A=;
 b=PeCKlhR+PRPOLu0nwHGV2GMIXMOjbrXHZVn0R45iXT6bYDIKoMPPCcrYcXKB6JdnsTiN6x
 2+2/67+KoWDgUEIHJkONW2I5hu3S4AZ+WhObLQqzIbPIUWQSgyOKqM33KatADGhgFXqXkv
 3T+r9+KvCClxJiGjXccUAIo2kpRhG0g=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-610-CodAjeVKPbKbkycZxEe6NA-1; Tue,
 17 Mar 2026 10:51:20 -0400
X-MC-Unique: CodAjeVKPbKbkycZxEe6NA-1
X-Mimecast-MFC-AGG-ID: CodAjeVKPbKbkycZxEe6NA_1773759079
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 723BF1954ACF; Tue, 17 Mar 2026 14:51:12 +0000 (UTC)
Received: from [10.44.32.37] (unknown [10.44.32.37])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B7751955F2B; Tue, 17 Mar 2026 14:51:10 +0000 (UTC)
Message-ID: <b4db6dcf-a55c-4c11-bae7-c19f8f03d755@redhat.com>
Date: Tue, 17 Mar 2026 15:51:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tests/lcitool: Update openSUSE to version 16
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>
References: <20260316135407.209072-1-thuth@redhat.com>
 <20260316135407.209072-3-thuth@redhat.com> <877brbomx1.fsf@draig.linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <877brbomx1.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 16/03/2026 15.43, Alex Bennée wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> From: Thomas Huth <thuth@redhat.com>
>>
>> The first version of openSUSE 15 has been released in 2018, and
>> according to our support policy, we "support the most recent major
>> version at all times for up to five years after its initial release."
>>
>> Since openSUSE 16 has been released a while ago, and openSUSE is
>> clearly older than 5 years already, it's time to update to version 16
>> now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   configure                  |  1 -
>>   tests/lcitool/mappings.yml | 58 --------------------------------------
>>   tests/lcitool/refresh      |  2 +-
>>   3 files changed, 1 insertion(+), 60 deletions(-)
>>
>> diff --git a/configure b/configure
>> index cd1dadd8bb2..f3603fd9160 100755
>> --- a/configure
>> +++ b/configure
>> @@ -929,7 +929,6 @@ if ! check_py_version "$python"; then
>>     error_exit "Cannot use '$python', Python >= 3.9 is required." \
>>                "Use --python=/path/to/python to specify a supported Python." \
>>                "Maybe try:" \
>> -             "  openSUSE Leap 15.3+: zypper install python39" \
>>                "  CentOS: dnf install python3.12"
>>   fi
>>   
>> diff --git a/tests/lcitool/mappings.yml b/tests/lcitool/mappings.yml
>> index 60618971584..62fe60d047f 100644
>> --- a/tests/lcitool/mappings.yml
>> +++ b/tests/lcitool/mappings.yml
>> @@ -3,70 +3,17 @@ mappings:
>>     bindgen:
>>       Ubuntu2204:
>>   
>> -  flake8:
>> -    OpenSUSELeap15:
>> -
>>     meson:
>> -    OpenSUSELeap15:
>>       # Use Meson from PyPI wherever Rust is enabled
>>       Debian:
>>       Fedora:
>>       Ubuntu:
>>   
>> -  python3:
>> -    OpenSUSELeap15: python311-base
>> -
>> -  python3-PyYAML:
>> -    OpenSUSELeap15:
>> -
>> -  python3-devel:
>> -    OpenSUSELeap15: python311-devel
>> -
>> -  python3-docutils:
>> -    OpenSUSELeap15:
>> -
>> -  python3-numpy:
>> -    OpenSUSELeap15:
>> -
>> -  python3-opencv:
>> -    OpenSUSELeap15:
>> -
>> -  python3-pillow:
>> -    OpenSUSELeap15:
>> -
>> -  python3-pip:
>> -    OpenSUSELeap15: python311-pip
>> -
>> -  python3-pillow:
>> -    OpenSUSELeap15:
>> -
>> -  python3-selinux:
>> -    OpenSUSELeap15:
>> -
>> -  python3-setuptools:
>> -    OpenSUSELeap15: python311-setuptools
>> -
>> -  python3-sphinx:
>> -    OpenSUSELeap15:
>> -
>> -  python3-sphinx-rtd-theme:
>> -    OpenSUSELeap15:
>> -
>> -  python3-sqlite3:
>> -    OpenSUSELeap15: python311
>> -
>>     python3-tomli:
>>       # test using tomllib
>>       apk:
>>       Fedora:
>>       Debian12:
>> -    OpenSUSELeap15:
>> -
>> -  python3-venv:
>> -    OpenSUSELeap15: python311-base
>> -
>> -  python3-wheel:
>> -    OpenSUSELeap15: python311-wheel
>>   
>>     rust:
>>       Debian12: rustc-web
>> @@ -79,12 +26,7 @@ pypi_mappings:
>>       default: meson==1.8.1
>>   
>>     # Drop packages that need devel headers
>> -  python3-numpy:
>> -    OpenSUSELeap15:
>> -
>> -  # see above
>>     python3-tomli:
>>       apk:
>>       Fedora:
>>       Debian12:
>> -    OpenSUSELeap15:
> 
> I'm unsure about the mappings stuff just because I'm not sure what it is
> for. Does it supplement the mappings in libvirt-ci itself?

Yes, that's how I understood it. Since this is just an extension to the 
mappings from libvirt-ci, I think we can safely remove those mappings on the 
QEMU side now.

  Thomas


