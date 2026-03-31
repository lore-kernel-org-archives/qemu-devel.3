Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522FD109B468
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:07:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YoW-0001JA-SR; Tue, 31 Mar 2026 09:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7YoV-0001El-LY
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1w7YoS-0002jC-Sf
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:07:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774962438;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mn+uyV1OMbCaJZd+CkO4C5Q7SZsTkXeLduOo/BE8rKg=;
 b=UQWKk2HUVYjAPAcbOox/6mvdDThQXeaygl5/yP4W0pzQcwlEwjeRg2ZiiGv3Mh06RaLN3z
 tNcK+3cl56yXfdnmT4jW90HjhWN9BW9WMElfQ4VhP7MxcG41u0qXsq6HVuYCVLDwdXT22W
 KzpwEEcoOEDM1OXpKWXb8WnGKFwm970=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-618-a-bNpCZ7Mw2-Rvk_BVRv2A-1; Tue,
 31 Mar 2026 09:07:16 -0400
X-MC-Unique: a-bNpCZ7Mw2-Rvk_BVRv2A-1
X-Mimecast-MFC-AGG-ID: a-bNpCZ7Mw2-Rvk_BVRv2A_1774962435
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9813E180035C
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 13:07:15 +0000 (UTC)
Received: from redhat.com (unknown [10.44.50.79])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CC8DA1955F42; Tue, 31 Mar 2026 13:07:13 +0000 (UTC)
Date: Tue, 31 Mar 2026 14:07:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: Elizabeth Ashurov <eashurov@redhat.com>, qemu-devel@nongnu.org,
 yvugenfi@redhat.com
Subject: Re: [PATCH v2] qga: add security info to guest-get-osinfo
Message-ID: <acvG_qekxd3I_Iw5@redhat.com>
References: <20260330151941.2207789-1-eashurov@redhat.com>
 <acu5ORMkk3q0Zt4b@redhat.com>
 <CAPMcbCpzzte9dvR5-PJpyYipYEyWaPKjC+HMP-jQJUAAnhORsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCpzzte9dvR5-PJpyYipYEyWaPKjC+HMP-jQJUAAnhORsw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 31, 2026 at 03:55:01PM +0300, Kostiantyn Kostiuk wrote:
> Best Regards,
> Kostiantyn Kostiuk.
> 
> 
> On Tue, Mar 31, 2026 at 3:08 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Mon, Mar 30, 2026 at 06:19:41PM +0300, Elizabeth Ashurov wrote:
> > > Extend guest-get-osinfo to include security features status
> > > (VBS, Secure Boot, TPM) in a nested 'security' field.
> > > OS-specific data (e.g. Windows DeviceGuard) is separated
> > > using a union to allow future per-OS extensions.
> > >
> > > The implementation queries Win32_DeviceGuard and Win32_Tpm via
> > > WMI, and reads the SecureBoot UEFI variable through
> > > GetFirmwareEnvironmentVariable().
> > >
> > > Signed-off-by: Elizabeth Ashurov <eashurov@redhat.com>
> > > ---
> > >  qga/commands-win32.c | 421 +++++++++++++++++++++++++++++++++++++++++++
> >
> > This should also provide a Linux impl for the TPM and secureboot info as
> > that is platform portable and easily available.
> >
> > >  qga/qapi-schema.json |  91 +++++++++-
> > >  2 files changed, 511 insertions(+), 1 deletion(-)
> >
> > > +
> > > +/*
> > > + * Read the SecureBoot UEFI variable.  On legacy BIOS systems the field
> > > + * is omitted (not applicable).
> > > + */
> > > +static void get_secure_boot_status(GuestSecurityInfo *info,
> > > +                                   Error **errp)
> > > +{
> > > +    Error *local_err = NULL;
> > > +    BYTE value = 0;
> > > +    DWORD ret;
> > > +
> > > +    acquire_privilege(SE_SYSTEM_ENVIRONMENT_NAME, &local_err);
> > > +    if (local_err) {
> > > +        error_propagate(errp, local_err);
> > > +        return;
> > > +    }
> > > +
> > > +    ret = GetFirmwareEnvironmentVariableA("SecureBoot",
> > > +        "{8be4df61-93ca-11d2-aa0d-00e098032b8c}", &value,
> > sizeof(value));
> > > +
> > > +    if (ret == 0) {
> > > +        DWORD err = GetLastError();
> > > +        if (err == ERROR_INVALID_FUNCTION) {
> > > +            return;
> > > +        }
> > > +        if (err == ERROR_ENVVAR_NOT_FOUND) {
> > > +            info->has_secure_boot = true;
> > > +            info->secure_boot = false;
> > > +            return;
> > > +        }
> > > +        error_setg_win32(errp, err,
> > > +                         "failed to read SecureBoot UEFI variable");
> > > +        return;
> > > +    }
> > > +
> > > +    info->has_secure_boot = true;
> > > +    info->secure_boot = (value == 1);
> >
> > Is that comparison of 'value == 1' definitely correct ?  My
> > understanding was that secure boot state is indicated by the 5th byte
> > in that EFI variable.
> >
> 
> In MSFT sample
> https://github.com/microsoft/Windows-universal-samples/blob/main/Samples/CustomCapability/Service/Client/uefi.cpp
> the reverse logic is used.
> But from our testing on Windows, this comparison is correct.
> 
> 
> >
> >
> >
> > > +}
> > > +
> > > +/*
> > > + * Query Win32_Tpm WMI class for TPM presence and version.
> > > + */
> > > +static void get_tpm_info(GuestSecurityInfo *info, Error **errp)
> > > +{
> > > +    Error *local_err = NULL;
> > > +    IWbemServices *services = NULL;
> > > +    IEnumWbemClassObject *enumerator = NULL;
> > > +    IWbemClassObject *obj = NULL;
> > > +    ULONG count = 0;
> > > +    HRESULT hr;
> > > +    VARIANT var;
> > > +
> > > +    services = wmi_connect_to_namespace(
> > > +        L"ROOT\\CIMV2\\Security\\MicrosoftTpm", &local_err);
> > > +    if (!services) {
> > > +        /* TPM namespace may not exist -- field omitted (unknown) */
> > > +        error_free(local_err);
> > > +        return;
> > > +    }
> > > +
> > > +    enumerator = wmi_exec_query(services,
> > > +        L"SELECT * FROM Win32_Tpm", &local_err);
> > > +    if (!enumerator) {
> > > +        error_free(local_err);
> > > +        goto out;
> > > +    }
> > > +
> > > +    hr = enumerator->lpVtbl->Next(enumerator, WBEM_INFINITE, 1,
> > > +                                   &obj, &count);
> > > +    if (FAILED(hr) || count == 0) {
> > > +        info->has_tpm_present = true;
> > > +        info->tpm_present = false;
> > > +        goto out;
> > > +    }
> > > +
> > > +    info->has_tpm_present = true;
> > > +    info->tpm_present = true;
> > > +
> > > +    VariantInit(&var);
> > > +    if (SUCCEEDED(wmi_get_property(obj, L"SpecVersion", &var)) &&
> > > +        V_VT(&var) == VT_BSTR && V_BSTR(&var)) {
> > > +        info->tpm_version = g_utf16_to_utf8(
> > > +            (const gunichar2 *)V_BSTR(&var), -1, NULL, NULL, NULL);
> > > +        if (info->tpm_version) {
> > > +            /* keep only the part before the first comma */
> > > +            char *comma = strchr(info->tpm_version, ',');
> >
> > It would be helpful if the comment included a full example string
> > from "SpecVersion", so we can see what we're parsing here.
> >
> > > +            if (comma) {
> > > +                *comma = '\0';
> > > +            }
> > > +        }
> > > +    }
> > > +    VariantClear(&var);
> >
> >
> > > diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> > > index c57bc9a02f..2247f77cff 100644
> > > --- a/qga/qapi-schema.json
> > > +++ b/qga/qapi-schema.json
> > > @@ -1490,6 +1490,8 @@
> > >  #     * POSIX: as defined by os-release(5)
> > >  #     * Windows: contains string "server" or "client"
> > >  #
> > > +# @security: Security features status (since 10.3)
> > > +#
> > >  # .. note:: On POSIX systems the fields @id, @name, @pretty-name,
> > >  #    @version, @version-id, @variant and @variant-id follow the
> > >  #    definition specified in os-release(5).  Refer to the manual page
> > > @@ -1508,7 +1510,8 @@
> > >        '*kernel-release': 'str', '*kernel-version': 'str',
> > >        '*machine': 'str', '*id': 'str', '*name': 'str',
> > >        '*pretty-name': 'str', '*version': 'str', '*version-id': 'str',
> > > -      '*variant': 'str', '*variant-id': 'str' } }
> > > +      '*variant': 'str', '*variant-id': 'str',
> > > +      '*security': 'GuestSecurityInfo' } }
> > >
> > >  ##
> > >  # @guest-get-osinfo:
> > > @@ -1952,3 +1955,89 @@
> > >    'returns': ['GuestNetworkRoute'],
> > >    'if': { 'any': ['CONFIG_LINUX', 'CONFIG_WIN32'] }
> > >  }
> > > +
> > > +##
> > > +# @GuestSecurityInfoWindows:
> > > +#
> > > +# Windows-specific security features from Win32_DeviceGuard.
> > > +#
> > > +# @vbs-status: VirtualizationBasedSecurityStatus
> > > +#
> > > +# @available-security-properties:
> > > +#     AvailableSecurityProperties
> > > +#
> > > +# @code-integrity-policy-enforcement-status:
> > > +#     CodeIntegrityPolicyEnforcementStatus
> > > +#
> > > +# @required-security-properties: RequiredSecurityProperties
> > > +#
> > > +# @security-services-configured:
> > > +#     SecurityServicesConfigured
> > > +#
> > > +# @security-services-running: SecurityServicesRunning
> > > +#
> > > +# @usr-cfg-code-integrity-policy-enforcement-status:
> > > +#     UsermodeCodeIntegrityPolicyEnforcementStatus
> >
> > None of these docs are actually useful. Can you explain in plain
> > language what they each mean.
> >
> > > +#
> > > +# Since: 10.3
> > > +##
> > > +{ 'struct': 'GuestSecurityInfoWindows',
> > > +  'data': {
> > > +      '*vbs-status': 'int',
> > > +      '*available-security-properties': ['int'],
> > > +      '*code-integrity-policy-enforcement-status': 'int',
> > > +      '*required-security-properties': ['int'],
> > > +      '*security-services-configured': ['int'],
> > > +      '*security-services-running': ['int'],
> > > +      '*usr-cfg-code-integrity-policy-enforcement-status':
> > > +          'int' } }
> >
> > I'm guessing there that the are all largely reflecting enumerated
> > values from the Windows API. I'm wondering how they will be
> > consumed by whatever calls this command. Would they be better off
> > as enums, instead of plain ints, or arrays of ints ?
> >
> 
> There is no any existing enum in the Win32 API, as I know.
> If we introduce it, we should care about any updates from the MSFT side.
> Explanation of these numbers
> https://learn.microsoft.com/en-us/windows/security/hardware-security/enable-virtualization-based-protection-of-code-integrity?tabs=security
> 
> looks complicated, and I am not sure whether it is better to return
> "HardwareEnforcedStackProtectionInAuditMode" is better than 6.
> 
> Currently, QGA returns data in the same format as MSFT provides it.
> I think the management system should make a decision based on this.
> 
> 
> >
> > > +
> > > +##
> > > +# @GuestSecurityInfoType:
> > > +#
> > > +# Guest operating system type for security info.
> > > +#
> > > +# @windows: Microsoft Windows
> > > +#
> > > +# Since: 10.3
> > > +##
> > > +{ 'enum': 'GuestSecurityInfoType',
> > > +  'data': ['windows'] }
> > > +
> > > +##
> > > +# @GuestSecurityInfoOs:
> > > +#
> > > +# OS-specific security information.
> > > +#
> > > +# @type: guest operating system type
> > > +#
> > > +# Since: 10.3
> > > +##
> > > +{ 'union': 'GuestSecurityInfoOs',
> > > +  'base': { 'type': 'GuestSecurityInfoType' },
> > > +  'discriminator': 'type',
> > > +  'data': {
> > > +      'windows': 'GuestSecurityInfoWindows' } }
> > > +
> > > +##
> > > +# @GuestSecurityInfo:
> > > +#
> > > +# Guest security features status.  Fields are optional; a missing
> > > +# field means the information is not available on this platform.
> > > +#
> > > +# @tpm-present: Whether a TPM device is present
> > > +#
> > > +# @tpm-version: TPM specification version (e.g. "2.0")
> > > +#
> > > +# @secure-boot: Whether UEFI Secure Boot is enabled
> > > +#
> > > +# @os: OS-specific security information
> > > +#
> > > +# Since: 10.3
> > > +##
> > > +{ 'struct': 'GuestSecurityInfo',
> > > +  'data': {
> > > +      '*tpm-present': 'bool',
> > > +      '*tpm-version': 'str',
> >
> > Should we have a GuestSecurityTPMInfo struct ?
> >
> >     '*tpm': 'GuestSecurityTPMInfo'
> >
> > We would not need a "present" value, as the mere existence of the struct
> > data would indicate presence. Meanwhile this struct would contain a
> > mandatory version field:
> >
> >    { 'struct': 'GuestSecurityTPMInfo',
> >      'data': {
> >          'major-version': 'int'
> >      }
> >    }
> >
> > I suggest only reporting major version, as an int, not an arbitrary
> > string as that's ambiguous IMHO.  We could later add other TPM info
> > to this struct if needed.
> >
> > For Linux you can provide this TPM info by checking whether
> > /sys/class/tpm/tpm0 exists, and reading
> > /sys/class/tpm/tpm0/tpm_version_major
> >
> > > +      '*secure-boot': 'bool',
> >
> > For Linux you can provide this secureboot info by reading
> > /sys/firmware/efi/efivars/SecureBoot-8be4df61-93ca-11d2-aa0d-00e098032b8c
> >
> > This bool only tells us whether secureboot is enabled or not. I wonder
> > if we should allow for other info here too. Systemd's bootctl reads
> > various other secureboot fields "AuditMode", "DeployedMode", 'SetupMode'
> > and 'MokSBStateRT'.
> >
> > https://github.com/systemd/systemd/blob/main/src/basic/efivars.c#L381
> >
> > We could represent each as bools within a struct, eg
> >
> >   '*secure-boot': 'GuestSecuritySecureBootInfo'
> >
> > which would have several mandatory fields
> >
> >    { 'struct': 'GuestSecuritySecureBootInfo',
> >      'data': {
> >          'enabled': 'bool',
> >          'audit-mode': 'bool',
> >          'deployed-mode': 'bool',
> >          'setup-mode': 'bool',
> >          'mok-sb-state': 'bool',
> >
> 
> Any real use cases for all other fields?
> Or just get it because all of them are related to SB?

The security characteristics of a system with secure boot are more
granular than just a boolean on/off. These other variables give you
the full insight into the security of the system.

Further details are in the spec

  http://www.uefi.org/sites/default/files/resources/UEFI%20Spec%202_7_A%20Sept%206.pdf

Specifically the section "31.3 Firmware/OS Key Exchange: creating
trust relationships" is a large diagram showing the different modes
that are expressed by these variables. The exception mok-sb-state
which is something exposed by Shim, not a core UEFI variable, but
still important to overall system security.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


