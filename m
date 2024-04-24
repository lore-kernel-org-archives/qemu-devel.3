Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B138C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 09:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzYuy-0001Yj-Lg; Wed, 24 Apr 2024 05:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rzYux-0001YY-1C
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rzYus-00030C-9t
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 05:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713950869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9QsWuLqSss2Q6cIET5Ma/w9R0XNxLXqHtqWwzXMtUMI=;
 b=hk+CNhWU+d3lJwiyrrpEqCiKAnY/AlA2lnJjhhb+3H48IOHsP/YYjVxHRdj/XgviWancNN
 jWNtchQj9mn6jGKEW1OfcUBURh1f9hvI6UvCSVreaioOx2bFh++6c5lmgqvwADKHrLGR94
 ZrKhy4e0D2flgbNYGN+D/MQZvlnXZKA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-1trK7p8JOy2VlpCoIts9Kw-1; Wed, 24 Apr 2024 05:27:47 -0400
X-MC-Unique: 1trK7p8JOy2VlpCoIts9Kw-1
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-61b3b02f691so89785087b3.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 02:27:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713950866; x=1714555666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9QsWuLqSss2Q6cIET5Ma/w9R0XNxLXqHtqWwzXMtUMI=;
 b=uw5ZEoLOiIn2lou6Hdm9472zeuDpebXDXg0TXrms5ObOdOXIhOiQr1ZVCa6UI/XoUn
 fnTSFmNZXDMvaDBtTPcc4ONcVbfjRGpeFaZE3xkQ13hmrRJIo7U/NGbZIbC9051QI4Rp
 A/qBsmVz7UVDx/tULhO9ZwPKYm4IxGV4BY7+h53PE7/GC5BcXn8D5Xyd0LuAyyMZ6ZU3
 mAa79xMpbs4sUsVDmnwQmWU/gRC5gWH270E5k0ImxwC95j79PaKHdQu8+NOk2NmkDy8S
 wZCLNAs5JK8YbxdTTCa4Xsf87JGkrsgs2FjVltbqwk3o7JmLh4Yq/mtDRmya9Q2im3d/
 1m/w==
X-Gm-Message-State: AOJu0YzM5iDsBgN8fEtd4PIVOFPeGsnIxDGNKoh61XPlnGGxDS1dri59
 UYk+iio4dPN0U1hRjT8aa1GE5ffM6qTctlocNhlRFNwU0K65A21HJ9krLdkgmLxCoPod8S3i8C6
 VzERDNv1FsG+XY0D4ikb2VFIE4Rg4XOaKvTrq3IGZCnQ2wVTT2H7jlLikW3CD/r0BLNM+UU67u3
 A5zK0z2zW525aR1wJHvB3KOYA2zP0=
X-Received: by 2002:a05:690c:3346:b0:615:ecc:91c0 with SMTP id
 fk6-20020a05690c334600b006150ecc91c0mr1985809ywb.20.1713950866134; 
 Wed, 24 Apr 2024 02:27:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVY6wsf5m8I5v4BdgOJ3Cu8JubLiX3cJPCZ+mFl/RkEXUMoBQrVJOZV/Fk2ZyI5b9ze1yJdzZ9uKlDBHW2clE=
X-Received: by 2002:a05:690c:3346:b0:615:ecc:91c0 with SMTP id
 fk6-20020a05690c334600b006150ecc91c0mr1985796ywb.20.1713950865534; Wed, 24
 Apr 2024 02:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240423150005.48175-1-aidan_leuck@selinc.com>
 <20240423150005.48175-3-aidan_leuck@selinc.com>
In-Reply-To: <20240423150005.48175-3-aidan_leuck@selinc.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 24 Apr 2024 12:27:34 +0300
Message-ID: <CAPMcbCrxfC4p8RDUDHgEBn8-gWwo5BovOC-RcDYTvze--AuNag@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] Implement SSH commands in QEMU GA for Windows
To: aidan_leuck@selinc.com
Cc: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000080d6f90616d4484c"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000080d6f90616d4484c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 6:02=E2=80=AFPM <aidan_leuck@selinc.com> wrote:

> From: aidaleuc <aidan_leuck@selinc.com>
>
> Signed-off-by: aidaleuc <aidan_leuck@selinc.com>
>

Please resend with the real name in Signed-off-by

Assuming this changes:
Reviewed-by: Konstantin Kostiuk <kkostiuk@redhat.com>


> ---
>  qga/commands-windows-ssh.c | 712 +++++++++++++++++++++++++++++++++++++
>  qga/commands-windows-ssh.h |  26 ++
>  qga/meson.build            |   5 +-
>  qga/qapi-schema.json       |  17 +-
>  4 files changed, 749 insertions(+), 11 deletions(-)
>  create mode 100644 qga/commands-windows-ssh.c
>  create mode 100644 qga/commands-windows-ssh.h
>
> diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
> new file mode 100644
> index 0000000000..6a642e3ba8
> --- /dev/null
> +++ b/qga/commands-windows-ssh.c
> @@ -0,0 +1,712 @@
> +/*
> + * QEMU Guest Agent win32-specific command implementations for SSH keys.
> + * The implementation is opinionated and expects the SSH implementation =
to
> + * be OpenSSH.
> + *
> + * Copyright Schweitzer Engineering Laboratories. 2024
> + *
> + * Authors:
> + *  Aidan Leuck <aidan_leuck@selinc.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <aclapi.h>
> +#include <qga-qapi-types.h>
> +
> +#include "commands-common-ssh.h"
> +#include "commands-windows-ssh.h"
> +#include "guest-agent-core.h"
> +#include "limits.h"
> +#include "lmaccess.h"
> +#include "lmapibuf.h"
> +#include "lmerr.h"
> +#include "qapi/error.h"
> +
> +#include "qga-qapi-commands.h"
> +#include "sddl.h"
> +#include "shlobj.h"
> +#include "userenv.h"
> +
> +#define AUTHORIZED_KEY_FILE "authorized_keys"
> +#define AUTHORIZED_KEY_FILE_ADMIN "administrators_authorized_keys"
> +#define LOCAL_SYSTEM_SID "S-1-5-18"
> +#define ADMIN_SID "S-1-5-32-544"
> +
> +/*
> + * Frees userInfo structure. This implements the g_auto cleanup
> + * for the structure.
> + */
> +void free_userInfo(PWindowsUserInfo info)
> +{
> +    g_free(info->sshDirectory);
> +    g_free(info->authorizedKeyFile);
> +    LocalFree(info->SSID);
> +    g_free(info->username);
> +    g_free(info);
> +}
> +
> +/*
> + * Gets the admin SSH folder for OpenSSH. OpenSSH does not store
> + * the authorized_key file in the users home directory for security
> reasons and
> + * instead stores it at %PROGRAMDATA%/ssh. This function returns the pat=
h
> to
> + * that directory on the users machine
> + *
> + * parameters:
> + * errp -> error structure to set when an error occurs
> + * returns: The path to the ssh folder in %PROGRAMDATA% or NULL if an
> error
> + * occurred.
> + */
> +static char *get_admin_ssh_folder(Error **errp)
> +{
> +    /* Allocate memory for the program data path */
> +    g_autofree char *programDataPath =3D NULL;
> +    char *authkeys_path =3D NULL;
> +    PWSTR pgDataW =3D NULL;
> +    g_autoptr(GError) gerr =3D NULL;
> +
> +    /* Get the KnownFolderPath on the machine. */
> +    HRESULT folderResult =3D
> +        SHGetKnownFolderPath(&FOLDERID_ProgramData, 0, NULL, &pgDataW);
> +    if (folderResult !=3D S_OK) {
> +        error_setg(errp, "Failed to retrieve ProgramData folder");
> +        return NULL;
> +    }
> +
> +    /* Convert from a wide string back to a standard character string. *=
/
> +    programDataPath =3D g_utf16_to_utf8(pgDataW, -1, NULL, NULL, &gerr);
> +    CoTaskMemFree(pgDataW);
> +    if (!programDataPath) {
> +        error_setg(errp,
> +                   "Failed converting ProgramData folder path to UTF-16
> %s",
> +                   gerr->message);
> +        return NULL;
> +    }
> +
> +    /* Build the path to the file. */
> +    authkeys_path =3D g_build_filename(programDataPath, "ssh", NULL);
> +    return authkeys_path;
> +}
> +
> +/*
> + * Gets the path to the SSH folder for the specified user. If the user i=
s
> an
> + * admin it returns the ssh folder located at %PROGRAMDATA%/ssh. If the
> user is
> + * not an admin it returns %USERPROFILE%/.ssh
> + *
> + * parameters:
> + * username -> Username to get the SSH folder for
> + * isAdmin -> Whether the user is an admin or not
> + * errp -> Error structure to set any errors that occur.
> + * returns: path to the ssh folder as a string.
> + */
> +static char *get_ssh_folder(const char *username, const bool isAdmin,
> +                            Error **errp)
> +{
> +    DWORD maxSize =3D MAX_PATH;
> +    g_autofree char *profilesDir =3D g_new0(char, maxSize);
> +
> +    if (isAdmin) {
> +        return get_admin_ssh_folder(errp);
> +    }
> +
> +    /* If not an Admin the SSH key is in the user directory. */
> +    /* Get the user profile directory on the machine. */
> +    BOOL ret =3D GetProfilesDirectory(profilesDir, &maxSize);
> +    if (!ret) {
> +        error_setg_win32(errp, GetLastError(),
> +                         "failed to retrieve profiles directory");
> +        return NULL;
> +    }
> +
> +    /* Builds the filename */
> +    return g_build_filename(profilesDir, username, ".ssh", NULL);
> +}
> +
> +/*
> + * Creates an entry for the user so they can access the ssh folder in
> their
> + * userprofile.
> + *
> + * parameters:
> + * userInfo -> Information about the current user
> + * pACL -> Pointer to an ACL structure
> + * errp -> Error structure to set any errors that occur
> + * returns -> 1 on success, 0 otherwise
> + */
> +static bool create_acl_user(PWindowsUserInfo userInfo, PACL *pACL, Error
> **errp)
> +{
> +    const int aclSize =3D 1;
> +    PACL newACL =3D NULL;
> +    EXPLICIT_ACCESS eAccess[1];
> +    PSID userPSID =3D NULL;
> +
> +    /* Get a pointer to the internal SID object in Windows */
> +    bool converted =3D ConvertStringSidToSid(userInfo->SSID, &userPSID);
> +    if (!converted) {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve user
> %s SID",
> +                         userInfo->username);
> +        goto error;
> +    }
> +
> +    /* Set the permissions for the user. */
> +    eAccess[0].grfAccessPermissions =3D GENERIC_ALL;
> +    eAccess[0].grfAccessMode =3D SET_ACCESS;
> +    eAccess[0].grfInheritance =3D NO_INHERITANCE;
> +    eAccess[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
> +    eAccess[0].Trustee.TrusteeType =3D TRUSTEE_IS_USER;
> +    eAccess[0].Trustee.ptstrName =3D (LPTSTR)userPSID;
> +
> +    /* Set the ACL entries */
> +    DWORD setResult;
> +
> +    /*
> +     * If we are given a pointer that is already initialized, then we ca=
n
> merge
> +     * the existing entries instead of overwriting them.
> +     */
> +    if (*pACL) {
> +        setResult =3D SetEntriesInAcl(aclSize, eAccess, *pACL, &newACL);
> +    } else {
> +        setResult =3D SetEntriesInAcl(aclSize, eAccess, NULL, &newACL);
> +    }
> +
> +    if (setResult !=3D ERROR_SUCCESS) {
> +        error_setg_win32(errp, GetLastError(),
> +                         "failed to set ACL entries for user %s %lu",
> +                         userInfo->username, setResult);
> +        goto error;
> +    }
> +
> +    /* Free any old memory since we are going to overwrite the users
> pointer. */
> +    LocalFree(*pACL);
> +    *pACL =3D newACL;
> +
> +    LocalFree(userPSID);
> +    return true;
> +error:
> +    LocalFree(userPSID);
> +    return false;
> +}
> +
> +/*
> + * Creates a base ACL for both normal users and admins to share
> + * pACL -> Pointer to an ACL structure
> + * errp -> Error structure to set any errors that occur
> + * returns: 1 on success, 0 otherwise
> + */
> +static bool create_acl_base(PACL *pACL, Error **errp)
> +{
> +    PSID adminGroupPSID =3D NULL;
> +    PSID systemPSID =3D NULL;
> +
> +    const int aclSize =3D 2;
> +    EXPLICIT_ACCESS eAccess[2];
> +
> +    /* Create an entry for the system user. */
> +    const char *systemSID =3D LOCAL_SYSTEM_SID;
> +    bool converted =3D ConvertStringSidToSid(systemSID, &systemPSID);
> +    if (!converted) {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve syste=
m
> SID");
> +        goto error;
> +    }
> +
> +    /* set permissions for system user */
> +    eAccess[0].grfAccessPermissions =3D GENERIC_ALL;
> +    eAccess[0].grfAccessMode =3D SET_ACCESS;
> +    eAccess[0].grfInheritance =3D NO_INHERITANCE;
> +    eAccess[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
> +    eAccess[0].Trustee.TrusteeType =3D TRUSTEE_IS_USER;
> +    eAccess[0].Trustee.ptstrName =3D (LPTSTR)systemPSID;
> +
> +    /* Create an entry for the admin user. */
> +    const char *adminSID =3D ADMIN_SID;
> +    converted =3D ConvertStringSidToSid(adminSID, &adminGroupPSID);
> +    if (!converted) {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve Admin
> SID");
> +        goto error;
> +    }
> +
> +    /* Set permissions for admin group. */
> +    eAccess[1].grfAccessPermissions =3D GENERIC_ALL;
> +    eAccess[1].grfAccessMode =3D SET_ACCESS;
> +    eAccess[1].grfInheritance =3D NO_INHERITANCE;
> +    eAccess[1].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
> +    eAccess[1].Trustee.TrusteeType =3D TRUSTEE_IS_GROUP;
> +    eAccess[1].Trustee.ptstrName =3D (LPTSTR)adminGroupPSID;
> +
> +    /* Put the entries in an ACL object. */
> +    PACL pNewACL =3D NULL;
> +    DWORD setResult;
> +
> +    /*
> +     *If we are given a pointer that is already initialized, then we can
> merge
> +     *the existing entries instead of overwriting them.
> +     */
> +    if (*pACL) {
> +        setResult =3D SetEntriesInAcl(aclSize, eAccess, *pACL, &pNewACL)=
;
> +    } else {
> +        setResult =3D SetEntriesInAcl(aclSize, eAccess, NULL, &pNewACL);
> +    }
> +
> +    if (setResult !=3D ERROR_SUCCESS) {
> +        error_setg_win32(errp, GetLastError(),
> +                         "failed to set base ACL entries for system user
> and "
> +                         "admin group %lu",
> +                         setResult);
> +        goto error;
> +    }
> +
> +    LocalFree(adminGroupPSID);
> +    LocalFree(systemPSID);
> +
> +    /* Free any old memory since we are going to overwrite the users
> pointer. */
> +    LocalFree(*pACL);
> +
> +    *pACL =3D pNewACL;
> +
> +    return true;
> +
> +error:
> +    LocalFree(adminGroupPSID);
> +    LocalFree(systemPSID);
> +    return false;
> +}
> +
> +/*
> + * Sets the access control on the authorized_keys file and any ssh
> folders that
> + * need to be created. For administrators the required permissions on th=
e
> + * file/folders are that only administrators and the LocalSystem account
> can
> + * access the folders. For normal user accounts only the specified user,
> + * LocalSystem and Administrators can have access to the key.
> + *
> + * parameters:
> + * userInfo -> pointer to structure that contains information about the
> user
> + * PACL -> pointer to an access control structure that will be set upon
> + * successful completion of the function.
> + * errp -> error structure that will be set upon error.
> + * returns: 1 upon success 0 upon failure.
> + */
> +static bool create_acl(PWindowsUserInfo userInfo, PACL *pACL, Error
> **errp)
> +{
> +    /*
> +     * Creates a base ACL that both admins and users will share
> +     * This adds the Administrators group and the SYSTEM group
> +     */
> +    if (!create_acl_base(pACL, errp)) {
> +        return false;
> +    }
> +
> +    /*
> +     * If the user is not an admin give the user creating the key
> permission to
> +     * access the file.
> +     */
> +    if (!userInfo->isAdmin) {
> +        if (!create_acl_user(userInfo, pACL, errp)) {
> +            return false;
> +        }
> +
> +        return true;
> +    }
> +
> +    return true;
> +}
> +/*
> + * Create the SSH directory for the user and d sets appropriate
> permissions.
> + * In general the directory will be %PROGRAMDATA%/ssh if the user is an
> admin.
> + * %USERPOFILE%/.ssh if not an admin
> + *
> + * parameters:
> + * userInfo -> Contains information about the user
> + * errp -> Structure that will contain errors if the function fails.
> + * returns: zero upon failure, 1 upon success
> + */
> +static bool create_ssh_directory(WindowsUserInfo *userInfo, Error **errp=
)
> +{
> +    PACL pNewACL =3D NULL;
> +    g_autofree PSECURITY_DESCRIPTOR pSD =3D NULL;
> +
> +    /* Gets the appropriate ACL for the user */
> +    if (!create_acl(userInfo, &pNewACL, errp)) {
> +        goto error;
> +    }
> +
> +    /* Allocate memory for a security descriptor */
> +    pSD =3D g_malloc(SECURITY_DESCRIPTOR_MIN_LENGTH);
> +    if (!InitializeSecurityDescriptor(pSD, SECURITY_DESCRIPTOR_REVISION)=
)
> {
> +        error_setg_win32(errp, GetLastError(),
> +                         "Failed to initialize security descriptor");
> +        goto error;
> +    }
> +
> +    /* Associate the security descriptor with the ACL permissions. */
> +    if (!SetSecurityDescriptorDacl(pSD, TRUE, pNewACL, FALSE)) {
> +        error_setg_win32(errp, GetLastError(),
> +                         "Failed to set security descriptor ACL");
> +        goto error;
> +    }
> +
> +    /* Set the security attributes on the folder */
> +    SECURITY_ATTRIBUTES sAttr;
> +    sAttr.bInheritHandle =3D FALSE;
> +    sAttr.nLength =3D sizeof(SECURITY_ATTRIBUTES);
> +    sAttr.lpSecurityDescriptor =3D pSD;
> +
> +    /* Create the directory with the created permissions */
> +    BOOL created =3D CreateDirectory(userInfo->sshDirectory, &sAttr);
> +    if (!created) {
> +        error_setg_win32(errp, GetLastError(), "failed to create
> directory %s",
> +                         userInfo->sshDirectory);
> +        goto error;
> +    }
> +
> +    /* Free memory */
> +    LocalFree(pNewACL);
> +    return true;
> +error:
> +    LocalFree(pNewACL);
> +    return false;
> +}
> +
> +/*
> + * Sets permissions on the authorized_key_file that is created.
> + *
> + * parameters: userInfo -> Information about the user
> + * errp -> error structure that will contain errors upon failure
> + * returns: 1 upon success, zero upon failure.
> + */
> +static bool set_file_permissions(PWindowsUserInfo userInfo, Error **errp=
)
> +{
> +    PACL pACL =3D NULL;
> +    PSID userPSID;
> +
> +    /* Creates the access control structure */
> +    if (!create_acl(userInfo, &pACL, errp)) {
> +        goto error;
> +    }
> +
> +    /* Get the PSID structure for the user based off the string SID. */
> +    bool converted =3D ConvertStringSidToSid(userInfo->SSID, &userPSID);
> +    if (!converted) {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve user
> %s SID",
> +                         userInfo->username);
> +        goto error;
> +    }
> +
> +    /* Prevents permissions from being inherited and use the DACL
> provided. */
> +    const SE_OBJECT_TYPE securityBitFlags =3D
> +        DACL_SECURITY_INFORMATION | PROTECTED_DACL_SECURITY_INFORMATION;
> +
> +    /* Set the ACL on the file. */
> +    if (SetNamedSecurityInfo(userInfo->authorizedKeyFile, SE_FILE_OBJECT=
,
> +                             securityBitFlags, userPSID, NULL, pACL,
> +                             NULL) !=3D ERROR_SUCCESS) {
> +        error_setg_win32(errp, GetLastError(),
> +                         "failed to set file security for file %s",
> +                         userInfo->authorizedKeyFile);
> +        goto error;
> +    }
> +
> +    LocalFree(pACL);
> +    LocalFree(userPSID);
> +    return true;
> +
> +error:
> +    LocalFree(pACL);
> +    LocalFree(userPSID);
> +
> +    return false;
> +}
> +
> +/*
> + * Writes the specified keys to the authenticated keys file.
> + * parameters:
> + * userInfo: Information about the user we are writing the authkeys file
> to.
> + * authkeys: Array of keys to write to disk
> + * errp: Error structure that will contain any errors if they occur.
> + * returns: 1 if successful, 0 otherwise.
> + */
> +static bool write_authkeys(WindowsUserInfo *userInfo, GStrv authkeys,
> +                           Error **errp)
> +{
> +    g_autofree char *contents =3D NULL;
> +    g_autoptr(GError) err =3D NULL;
> +
> +    contents =3D g_strjoinv("\n", authkeys);
> +
> +    if (!g_file_set_contents(userInfo->authorizedKeyFile, contents, -1,
> &err)) {
> +        error_setg(errp, "failed to write to '%s': %s",
> +                   userInfo->authorizedKeyFile, err->message);
> +        return false;
> +    }
> +
> +    if (!set_file_permissions(userInfo, errp)) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +/*
> + * Retrieves information about a Windows user by their username
> + *
> + * parameters:
> + * userInfo -> Double pointer to a WindowsUserInfo structure. Upon
> success, it
> + * will be allocated with information about the user and need to be free=
d.
> + * username -> Name of the user to lookup.
> + * errp -> Contains any errors that occur.
> + * returns: 1 upon success, 0 upon failure.
> + */
> +static bool get_user_info(PWindowsUserInfo *userInfo, const char
> *username,
> +                          Error **errp)
> +{
> +    DWORD infoLevel =3D 4;
> +    LPUSER_INFO_4 uBuf =3D NULL;
> +    g_autofree wchar_t *wideUserName =3D NULL;
> +    g_autoptr(GError) gerr =3D NULL;
> +    PSID psid =3D NULL;
> +
> +    /*
> +     * Converts a string to a Windows wide string since the GetNetUserIn=
fo
> +     * function requires it.
> +     */
> +    wideUserName =3D g_utf8_to_utf16(username, -1, NULL, NULL, &gerr);
> +    if (!wideUserName) {
> +        goto error;
> +    }
> +
> +    /* allocate data */
> +    PWindowsUserInfo uData =3D g_new0(WindowsUserInfo, 1);
> +
> +    /* Set pointer so it can be cleaned up by the callee, even upon
> error. */
> +    *userInfo =3D uData;
> +
> +    /* Find the information */
> +    NET_API_STATUS result =3D
> +        NetUserGetInfo(NULL, wideUserName, infoLevel, (LPBYTE *)&uBuf);
> +    if (result !=3D NERR_Success) {
> +        /* Give a friendlier error message if the user was not found. */
> +        if (result =3D=3D NERR_UserNotFound) {
> +            error_setg(errp, "User %s was not found", username);
> +            goto error;
> +        }
> +
> +        error_setg(errp,
> +                   "Received unexpected error when asking for user info:
> Error "
> +                   "Code %lu",
> +                   result);
> +        goto error;
> +    }
> +
> +    /* Get information from the buffer returned by NetUserGetInfo. */
> +    uData->username =3D g_strdup(username);
> +    uData->isAdmin =3D uBuf->usri4_priv =3D=3D USER_PRIV_ADMIN;
> +    psid =3D uBuf->usri4_user_sid;
> +
> +    char *sidStr =3D NULL;
> +
> +    /*
> +     * We store the string representation of the SID not SID structure i=
n
> +     * memory. Callees wanting to use the SID structure should call
> +     * ConvertStringSidToSID.
> +     */
> +    if (!ConvertSidToStringSid(psid, &sidStr)) {
> +        error_setg_win32(errp, GetLastError(),
> +                         "failed to get SID string for user %s",
> username);
> +        goto error;
> +    }
> +
> +    /* Store the SSID */
> +    uData->SSID =3D sidStr;
> +
> +    /* Get the SSH folder for the user. */
> +    char *sshFolder =3D get_ssh_folder(username, uData->isAdmin, errp);
> +    if (sshFolder =3D=3D NULL) {
> +        goto error;
> +    }
> +
> +    /* Get the authorized key file path */
> +    const char *authorizedKeyFile =3D
> +        uData->isAdmin ? AUTHORIZED_KEY_FILE_ADMIN : AUTHORIZED_KEY_FILE=
;
> +    char *authorizedKeyPath =3D
> +        g_build_filename(sshFolder, authorizedKeyFile, NULL);
> +    uData->sshDirectory =3D sshFolder;
> +    uData->authorizedKeyFile =3D authorizedKeyPath;
> +
> +    /* Free */
> +    NetApiBufferFree(uBuf);
> +    return true;
> +error:
> +    if (uBuf) {
> +        NetApiBufferFree(uBuf);
> +    }
> +
> +    return false;
> +}
> +
> +/*
> + * Gets the list of authorized keys for a user.
> + *
> + * parameters:
> + * username -> Username to retrieve the keys for.
> + * errp -> Error structure that will display any errors through QMP.
> + * returns: List of keys associated with the user.
> + */
> +GuestAuthorizedKeys *qmp_guest_ssh_get_authorized_keys(const char
> *username,
> +                                                       Error **errp)
> +{
> +    GuestAuthorizedKeys *keys =3D NULL;
> +    g_auto(GStrv) authKeys =3D NULL;
> +    g_autoptr(GuestAuthorizedKeys) ret =3D NULL;
> +    g_auto(PWindowsUserInfo) userInfo =3D NULL;
> +
> +    /* Gets user information */
> +    if (!get_user_info(&userInfo, username, errp)) {
> +        return NULL;
> +    }
> +
> +    /* Reads authkeys for the user */
> +    authKeys =3D read_authkeys(userInfo->authorizedKeyFile, errp);
> +    if (authKeys =3D=3D NULL) {
> +        return NULL;
> +    }
> +
> +    /* Set the GuestAuthorizedKey struct with keys from the file */
> +    ret =3D g_new0(GuestAuthorizedKeys, 1);
> +    for (int i =3D 0; authKeys[i] !=3D NULL; i++) {
> +        g_strstrip(authKeys[i]);
> +        if (!authKeys[i][0] || authKeys[i][0] =3D=3D '#') {
> +            continue;
> +        }
> +
> +        QAPI_LIST_PREPEND(ret->keys, g_strdup(authKeys[i]));
> +    }
> +
> +    /*
> +     * Steal the pointer because it is up for the callee to deallocate t=
he
> +     * memory.
> +     */
> +    keys =3D g_steal_pointer(&ret);
> +    return keys;
> +}
> +
> +/*
> + * Adds an ssh key for a user.
> + *
> + * parameters:
> + * username -> User to add the SSH key to
> + * strList -> Array of keys to add to the list
> + * has_reset -> Whether the keys have been reset
> + * reset -> Boolean to reset the keys (If this is set the existing list
> will be
> + * cleared) and the other key reset. errp -> Pointer to an error
> structure that
> + * will get returned over QMP if anything goes wrong.
> + */
> +void qmp_guest_ssh_add_authorized_keys(const char *username, strList
> *keys,
> +                                       bool has_reset, bool reset, Error
> **errp)
> +{
> +    g_auto(PWindowsUserInfo) userInfo =3D NULL;
> +    g_auto(GStrv) authkeys =3D NULL;
> +    strList *k;
> +    size_t nkeys, nauthkeys;
> +
> +    /* Make sure the keys given are valid */
> +    if (!check_openssh_pub_keys(keys, &nkeys, errp)) {
> +        return;
> +    }
> +
> +    /* Gets user information */
> +    if (!get_user_info(&userInfo, username, errp)) {
> +        return;
> +    }
> +
> +    /* Determine whether we should reset the keys */
> +    reset =3D has_reset && reset;
> +    if (!reset) {
> +        /* Read existing keys into memory */
> +        authkeys =3D read_authkeys(userInfo->authorizedKeyFile, NULL);
> +    }
> +
> +    /* Check that the SSH key directory exists for the user. */
> +    if (!g_file_test(userInfo->sshDirectory, G_FILE_TEST_IS_DIR)) {
> +        BOOL success =3D create_ssh_directory(userInfo, errp);
> +        if (!success) {
> +            return;
> +        }
> +    }
> +
> +    /* Reallocates the buffer to fit the new keys. */
> +    nauthkeys =3D authkeys ? g_strv_length(authkeys) : 0;
> +    authkeys =3D g_realloc_n(authkeys, nauthkeys + nkeys + 1, sizeof(cha=
r
> *));
> +
> +    /* zero out the memory for the reallocated buffer */
> +    memset(authkeys + nauthkeys, 0, (nkeys + 1) * sizeof(char *));
> +
> +    /* Adds the keys */
> +    for (k =3D keys; k !=3D NULL; k =3D k->next) {
> +        /* Check that the key doesn't already exist */
> +        if (g_strv_contains((const gchar *const *)authkeys, k->value)) {
> +            continue;
> +        }
> +
> +        authkeys[nauthkeys++] =3D g_strdup(k->value);
> +    }
> +
> +    /* Write the authkeys to the file. */
> +    write_authkeys(userInfo, authkeys, errp);
> +}
> +
> +/*
> + * Removes an SSH key for a user
> + *
> + * parameters:
> + * username -> Username to remove the key from
> + * strList -> List of strings to remove
> + * errp -> Contains any errors that occur.
> + */
> +void qmp_guest_ssh_remove_authorized_keys(const char *username, strList
> *keys,
> +                                          Error **errp)
> +{
> +    g_auto(PWindowsUserInfo) userInfo =3D NULL;
> +    g_autofree struct passwd *p =3D NULL;
> +    g_autofree GStrv new_keys =3D NULL; /* do not own the strings */
> +    g_auto(GStrv) authkeys =3D NULL;
> +    GStrv a;
> +    size_t nkeys =3D 0;
> +
> +    /* Validates the keys passed in by the user */
> +    if (!check_openssh_pub_keys(keys, NULL, errp)) {
> +        return;
> +    }
> +
> +    /* Gets user information */
> +    if (!get_user_info(&userInfo, username, errp)) {
> +        return;
> +    }
> +
> +    /* Reads the authkeys for the user */
> +    authkeys =3D read_authkeys(userInfo->authorizedKeyFile, errp);
> +    if (authkeys =3D=3D NULL) {
> +        return;
> +    }
> +
> +    /* Create a new buffer to hold the keys */
> +    new_keys =3D g_new0(char *, g_strv_length(authkeys) + 1);
> +    for (a =3D authkeys; *a !=3D NULL; a++) {
> +        strList *k;
> +
> +        /* Filters out keys that are equal to ones the user specified. *=
/
> +        for (k =3D keys; k !=3D NULL; k =3D k->next) {
> +            if (g_str_equal(k->value, *a)) {
> +                break;
> +            }
> +        }
> +
> +        if (k !=3D NULL) {
> +            continue;
> +        }
> +
> +        new_keys[nkeys++] =3D *a;
> +    }
> +
> +    /* Write the new authkeys to the file. */
> +    write_authkeys(userInfo, new_keys, errp);
> +}
> diff --git a/qga/commands-windows-ssh.h b/qga/commands-windows-ssh.h
> new file mode 100644
> index 0000000000..40ac67c4d9
> --- /dev/null
> +++ b/qga/commands-windows-ssh.h
> @@ -0,0 +1,26 @@
> +/*
> + * Header file for commands-windows-ssh.c
> + *
> + * Copyright Schweitzer Engineering Laboratories. 2024
> + *
> + * Authors:
> + *  Aidan Leuck <aidan_leuck@selinc.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or
> later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include <glib/gstrfuncs.h>
> +#include <stdbool.h>
> +typedef struct WindowsUserInfo {
> +    char *sshDirectory;
> +    char *authorizedKeyFile;
> +    char *username;
> +    char *SSID;
> +    bool isAdmin;
> +} WindowsUserInfo;
> +
> +typedef WindowsUserInfo *PWindowsUserInfo;
> +
> +void free_userInfo(PWindowsUserInfo info);
> +G_DEFINE_AUTO_CLEANUP_FREE_FUNC(PWindowsUserInfo, free_userInfo, NULL);
> diff --git a/qga/meson.build b/qga/meson.build
> index 4c3899751b..d5de492da3 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -73,7 +73,8 @@ if host_os =3D=3D 'windows'
>      'channel-win32.c',
>      'commands-win32.c',
>      'service-win32.c',
> -    'vss-win32.c'
> +    'vss-win32.c',
> +    'commands-windows-ssh.c'
>    ))
>  else
>    qga_ss.add(files(
> @@ -94,7 +95,7 @@ gen_tlb =3D []
>  qga_libs =3D []
>  if host_os =3D=3D 'windows'
>    qga_libs +=3D ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32',
> '-lwininet', '-liphlpapi', '-lnetapi32',
> -               '-lsetupapi', '-lcfgmgr32']
> +               '-lsetupapi', '-lcfgmgr32', '-luserenv']
>    if have_qga_vss
>      qga_libs +=3D ['-lole32', '-loleaut32', '-lshlwapi', '-lstdc++',
> '-Wl,--enable-stdcall-fixup']
>      subdir('vss-win32')
> diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
> index 9554b566a7..a64a6d91cf 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1562,9 +1562,8 @@
>  { 'struct': 'GuestAuthorizedKeys',
>    'data': {
>        'keys': ['str']
> -  },
> -  'if': 'CONFIG_POSIX' }
> -
> +  }
> +}
>
>  ##
>  # @guest-ssh-get-authorized-keys:
> @@ -1580,8 +1579,8 @@
>  ##
>  { 'command': 'guest-ssh-get-authorized-keys',
>    'data': { 'username': 'str' },
> -  'returns': 'GuestAuthorizedKeys',
> -  'if': 'CONFIG_POSIX' }
> +  'returns': 'GuestAuthorizedKeys'
> +}
>
>  ##
>  # @guest-ssh-add-authorized-keys:
> @@ -1599,8 +1598,8 @@
>  # Since: 5.2
>  ##
>  { 'command': 'guest-ssh-add-authorized-keys',
> -  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' },
> -  'if': 'CONFIG_POSIX' }
> +  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' }
> +}
>
>  ##
>  # @guest-ssh-remove-authorized-keys:
> @@ -1617,8 +1616,8 @@
>  # Since: 5.2
>  ##
>  { 'command': 'guest-ssh-remove-authorized-keys',
> -  'data': { 'username': 'str', 'keys': ['str'] },
> -  'if': 'CONFIG_POSIX' }
> +  'data': { 'username': 'str', 'keys': ['str'] }
> +}
>
>  ##
>  # @GuestDiskStats:
> --
> 2.34.1
>
>

--00000000000080d6f90616d4484c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Tue, Apr 23, 2024 at 6:02=E2=80=AF=
PM &lt;<a href=3D"mailto:aidan_leuck@selinc.com" target=3D"_blank">aidan_le=
uck@selinc.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">From: aidaleuc &lt;<a href=3D"mailto:aidan_leuck@selinc.com" =
target=3D"_blank">aidan_leuck@selinc.com</a>&gt;<br>
<br>
Signed-off-by: aidaleuc &lt;<a href=3D"mailto:aidan_leuck@selinc.com" targe=
t=3D"_blank">aidan_leuck@selinc.com</a>&gt;<br></blockquote><div><br></div>=
<div>Please resend with the real name in Signed-off-by</div><div><br></div>=
<div>Assuming this changes:</div>Reviewed-by: Konstantin Kostiuk &lt;<a hre=
f=3D"mailto:kkostiuk@redhat.com">kkostiuk@redhat.com</a>&gt;<div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0qga/commands-windows-ssh.c | 712 ++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/commands-windows-ssh.h |=C2=A0 26 ++<br>
=C2=A0qga/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A05 +-<br>
=C2=A0qga/qapi-schema.json=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 17 +-<br>
=C2=A04 files changed, 749 insertions(+), 11 deletions(-)<br>
=C2=A0create mode 100644 qga/commands-windows-ssh.c<br>
=C2=A0create mode 100644 qga/commands-windows-ssh.h<br>
<br>
diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c<br>
new file mode 100644<br>
index 0000000000..6a642e3ba8<br>
--- /dev/null<br>
+++ b/qga/commands-windows-ssh.c<br>
@@ -0,0 +1,712 @@<br>
+/*<br>
+ * QEMU Guest Agent win32-specific command implementations for SSH keys.<b=
r>
+ * The implementation is opinionated and expects the SSH implementation to=
<br>
+ * be OpenSSH.<br>
+ *<br>
+ * Copyright Schweitzer Engineering Laboratories. 2024<br>
+ *<br>
+ * Authors:<br>
+ *=C2=A0 Aidan Leuck &lt;<a href=3D"mailto:aidan_leuck@selinc.com" target=
=3D"_blank">aidan_leuck@selinc.com</a>&gt;<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
+ * See the COPYING file in the top-level directory.<br>
+ */<br>
+<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &lt;aclapi.h&gt;<br>
+#include &lt;qga-qapi-types.h&gt;<br>
+<br>
+#include &quot;commands-common-ssh.h&quot;<br>
+#include &quot;commands-windows-ssh.h&quot;<br>
+#include &quot;guest-agent-core.h&quot;<br>
+#include &quot;limits.h&quot;<br>
+#include &quot;lmaccess.h&quot;<br>
+#include &quot;lmapibuf.h&quot;<br>
+#include &quot;lmerr.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+<br>
+#include &quot;qga-qapi-commands.h&quot;<br>
+#include &quot;sddl.h&quot;<br>
+#include &quot;shlobj.h&quot;<br>
+#include &quot;userenv.h&quot;<br>
+<br>
+#define AUTHORIZED_KEY_FILE &quot;authorized_keys&quot;<br>
+#define AUTHORIZED_KEY_FILE_ADMIN &quot;administrators_authorized_keys&quo=
t;<br>
+#define LOCAL_SYSTEM_SID &quot;S-1-5-18&quot;<br>
+#define ADMIN_SID &quot;S-1-5-32-544&quot;<br>
+<br>
+/*<br>
+ * Frees userInfo structure. This implements the g_auto cleanup<br>
+ * for the structure.<br>
+ */<br>
+void free_userInfo(PWindowsUserInfo info)<br>
+{<br>
+=C2=A0 =C2=A0 g_free(info-&gt;sshDirectory);<br>
+=C2=A0 =C2=A0 g_free(info-&gt;authorizedKeyFile);<br>
+=C2=A0 =C2=A0 LocalFree(info-&gt;SSID);<br>
+=C2=A0 =C2=A0 g_free(info-&gt;username);<br>
+=C2=A0 =C2=A0 g_free(info);<br>
+}<br>
+<br>
+/*<br>
+ * Gets the admin SSH folder for OpenSSH. OpenSSH does not store<br>
+ * the authorized_key file in the users home directory for security reason=
s and<br>
+ * instead stores it at %PROGRAMDATA%/ssh. This function returns the path =
to<br>
+ * that directory on the users machine<br>
+ *<br>
+ * parameters:<br>
+ * errp -&gt; error structure to set when an error occurs<br>
+ * returns: The path to the ssh folder in %PROGRAMDATA% or NULL if an erro=
r<br>
+ * occurred.<br>
+ */<br>
+static char *get_admin_ssh_folder(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 /* Allocate memory for the program data path */<br>
+=C2=A0 =C2=A0 g_autofree char *programDataPath =3D NULL;<br>
+=C2=A0 =C2=A0 char *authkeys_path =3D NULL;<br>
+=C2=A0 =C2=A0 PWSTR pgDataW =3D NULL;<br>
+=C2=A0 =C2=A0 g_autoptr(GError) gerr =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /* Get the KnownFolderPath on the machine. */<br>
+=C2=A0 =C2=A0 HRESULT folderResult =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 SHGetKnownFolderPath(&amp;FOLDERID_ProgramData=
, 0, NULL, &amp;pgDataW);<br>
+=C2=A0 =C2=A0 if (folderResult !=3D S_OK) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to retrieve Prog=
ramData folder&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Convert from a wide string back to a standard character s=
tring. */<br>
+=C2=A0 =C2=A0 programDataPath =3D g_utf16_to_utf8(pgDataW, -1, NULL, NULL,=
 &amp;gerr);<br>
+=C2=A0 =C2=A0 CoTaskMemFree(pgDataW);<br>
+=C2=A0 =C2=A0 if (!programDataPath) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;Failed converting ProgramData folder path to UTF-16 %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0gerr-=
&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Build the path to the file. */<br>
+=C2=A0 =C2=A0 authkeys_path =3D g_build_filename(programDataPath, &quot;ss=
h&quot;, NULL);<br>
+=C2=A0 =C2=A0 return authkeys_path;<br>
+}<br>
+<br>
+/*<br>
+ * Gets the path to the SSH folder for the specified user. If the user is =
an<br>
+ * admin it returns the ssh folder located at %PROGRAMDATA%/ssh. If the us=
er is<br>
+ * not an admin it returns %USERPROFILE%/.ssh<br>
+ *<br>
+ * parameters:<br>
+ * username -&gt; Username to get the SSH folder for<br>
+ * isAdmin -&gt; Whether the user is an admin or not<br>
+ * errp -&gt; Error structure to set any errors that occur.<br>
+ * returns: path to the ssh folder as a string.<br>
+ */<br>
+static char *get_ssh_folder(const char *username, const bool isAdmin,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD maxSize =3D MAX_PATH;<br>
+=C2=A0 =C2=A0 g_autofree char *profilesDir =3D g_new0(char, maxSize);<br>
+<br>
+=C2=A0 =C2=A0 if (isAdmin) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_admin_ssh_folder(errp);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* If not an Admin the SSH key is in the user directory. */<=
br>
+=C2=A0 =C2=A0 /* Get the user profile directory on the machine. */<br>
+=C2=A0 =C2=A0 BOOL ret =3D GetProfilesDirectory(profilesDir, &amp;maxSize)=
;<br>
+=C2=A0 =C2=A0 if (!ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;failed to retrieve profiles directory&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Builds the filename */<br>
+=C2=A0 =C2=A0 return g_build_filename(profilesDir, username, &quot;.ssh&qu=
ot;, NULL);<br>
+}<br>
+<br>
+/*<br>
+ * Creates an entry for the user so they can access the ssh folder in thei=
r<br>
+ * userprofile.<br>
+ *<br>
+ * parameters:<br>
+ * userInfo -&gt; Information about the current user<br>
+ * pACL -&gt; Pointer to an ACL structure<br>
+ * errp -&gt; Error structure to set any errors that occur<br>
+ * returns -&gt; 1 on success, 0 otherwise<br>
+ */<br>
+static bool create_acl_user(PWindowsUserInfo userInfo, PACL *pACL, Error *=
*errp)<br>
+{<br>
+=C2=A0 =C2=A0 const int aclSize =3D 1;<br>
+=C2=A0 =C2=A0 PACL newACL =3D NULL;<br>
+=C2=A0 =C2=A0 EXPLICIT_ACCESS eAccess[1];<br>
+=C2=A0 =C2=A0 PSID userPSID =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /* Get a pointer to the internal SID object in Windows */<br=
>
+=C2=A0 =C2=A0 bool converted =3D ConvertStringSidToSid(userInfo-&gt;SSID, =
&amp;userPSID);<br>
+=C2=A0 =C2=A0 if (!converted) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to retrieve user %s SID&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0userInfo-&gt;username);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Set the permissions for the user. */<br>
+=C2=A0 =C2=A0 eAccess[0].grfAccessPermissions =3D GENERIC_ALL;<br>
+=C2=A0 =C2=A0 eAccess[0].grfAccessMode =3D SET_ACCESS;<br>
+=C2=A0 =C2=A0 eAccess[0].grfInheritance =3D NO_INHERITANCE;<br>
+=C2=A0 =C2=A0 eAccess[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;<br>
+=C2=A0 =C2=A0 eAccess[0].Trustee.TrusteeType =3D TRUSTEE_IS_USER;<br>
+=C2=A0 =C2=A0 eAccess[0].Trustee.ptstrName =3D (LPTSTR)userPSID;<br>
+<br>
+=C2=A0 =C2=A0 /* Set the ACL entries */<br>
+=C2=A0 =C2=A0 DWORD setResult;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If we are given a pointer that is already initialize=
d, then we can merge<br>
+=C2=A0 =C2=A0 =C2=A0* the existing entries instead of overwriting them.<br=
>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (*pACL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 setResult =3D SetEntriesInAcl(aclSize, eAccess=
, *pACL, &amp;newACL);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 setResult =3D SetEntriesInAcl(aclSize, eAccess=
, NULL, &amp;newACL);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (setResult !=3D ERROR_SUCCESS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;failed to set ACL entries for user %s %lu&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0userInfo-&gt;username, setResult);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Free any old memory since we are going to overwrite the u=
sers pointer. */<br>
+=C2=A0 =C2=A0 LocalFree(*pACL);<br>
+=C2=A0 =C2=A0 *pACL =3D newACL;<br>
+<br>
+=C2=A0 =C2=A0 LocalFree(userPSID);<br>
+=C2=A0 =C2=A0 return true;<br>
+error:<br>
+=C2=A0 =C2=A0 LocalFree(userPSID);<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+/*<br>
+ * Creates a base ACL for both normal users and admins to share<br>
+ * pACL -&gt; Pointer to an ACL structure<br>
+ * errp -&gt; Error structure to set any errors that occur<br>
+ * returns: 1 on success, 0 otherwise<br>
+ */<br>
+static bool create_acl_base(PACL *pACL, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 PSID adminGroupPSID =3D NULL;<br>
+=C2=A0 =C2=A0 PSID systemPSID =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 const int aclSize =3D 2;<br>
+=C2=A0 =C2=A0 EXPLICIT_ACCESS eAccess[2];<br>
+<br>
+=C2=A0 =C2=A0 /* Create an entry for the system user. */<br>
+=C2=A0 =C2=A0 const char *systemSID =3D LOCAL_SYSTEM_SID;<br>
+=C2=A0 =C2=A0 bool converted =3D ConvertStringSidToSid(systemSID, &amp;sys=
temPSID);<br>
+=C2=A0 =C2=A0 if (!converted) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to retrieve system SID&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* set permissions for system user */<br>
+=C2=A0 =C2=A0 eAccess[0].grfAccessPermissions =3D GENERIC_ALL;<br>
+=C2=A0 =C2=A0 eAccess[0].grfAccessMode =3D SET_ACCESS;<br>
+=C2=A0 =C2=A0 eAccess[0].grfInheritance =3D NO_INHERITANCE;<br>
+=C2=A0 =C2=A0 eAccess[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;<br>
+=C2=A0 =C2=A0 eAccess[0].Trustee.TrusteeType =3D TRUSTEE_IS_USER;<br>
+=C2=A0 =C2=A0 eAccess[0].Trustee.ptstrName =3D (LPTSTR)systemPSID;<br>
+<br>
+=C2=A0 =C2=A0 /* Create an entry for the admin user. */<br>
+=C2=A0 =C2=A0 const char *adminSID =3D ADMIN_SID;<br>
+=C2=A0 =C2=A0 converted =3D ConvertStringSidToSid(adminSID, &amp;adminGrou=
pPSID);<br>
+=C2=A0 =C2=A0 if (!converted) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to retrieve Admin SID&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Set permissions for admin group. */<br>
+=C2=A0 =C2=A0 eAccess[1].grfAccessPermissions =3D GENERIC_ALL;<br>
+=C2=A0 =C2=A0 eAccess[1].grfAccessMode =3D SET_ACCESS;<br>
+=C2=A0 =C2=A0 eAccess[1].grfInheritance =3D NO_INHERITANCE;<br>
+=C2=A0 =C2=A0 eAccess[1].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;<br>
+=C2=A0 =C2=A0 eAccess[1].Trustee.TrusteeType =3D TRUSTEE_IS_GROUP;<br>
+=C2=A0 =C2=A0 eAccess[1].Trustee.ptstrName =3D (LPTSTR)adminGroupPSID;<br>
+<br>
+=C2=A0 =C2=A0 /* Put the entries in an ACL object. */<br>
+=C2=A0 =C2=A0 PACL pNewACL =3D NULL;<br>
+=C2=A0 =C2=A0 DWORD setResult;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0*If we are given a pointer that is already initialized=
, then we can merge<br>
+=C2=A0 =C2=A0 =C2=A0*the existing entries instead of overwriting them.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (*pACL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 setResult =3D SetEntriesInAcl(aclSize, eAccess=
, *pACL, &amp;pNewACL);<br>
+=C2=A0 =C2=A0 } else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 setResult =3D SetEntriesInAcl(aclSize, eAccess=
, NULL, &amp;pNewACL);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (setResult !=3D ERROR_SUCCESS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;failed to set base ACL entries for system user and &=
quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;admin group %lu&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0setResult);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 LocalFree(adminGroupPSID);<br>
+=C2=A0 =C2=A0 LocalFree(systemPSID);<br>
+<br>
+=C2=A0 =C2=A0 /* Free any old memory since we are going to overwrite the u=
sers pointer. */<br>
+=C2=A0 =C2=A0 LocalFree(*pACL);<br>
+<br>
+=C2=A0 =C2=A0 *pACL =3D pNewACL;<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+<br>
+error:<br>
+=C2=A0 =C2=A0 LocalFree(adminGroupPSID);<br>
+=C2=A0 =C2=A0 LocalFree(systemPSID);<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+/*<br>
+ * Sets the access control on the authorized_keys file and any ssh folders=
 that<br>
+ * need to be created. For administrators the required permissions on the<=
br>
+ * file/folders are that only administrators and the LocalSystem account c=
an<br>
+ * access the folders. For normal user accounts only the specified user,<b=
r>
+ * LocalSystem and Administrators can have access to the key.<br>
+ *<br>
+ * parameters:<br>
+ * userInfo -&gt; pointer to structure that contains information about the=
 user<br>
+ * PACL -&gt; pointer to an access control structure that will be set upon=
<br>
+ * successful completion of the function.<br>
+ * errp -&gt; error structure that will be set upon error.<br>
+ * returns: 1 upon success 0 upon failure.<br>
+ */<br>
+static bool create_acl(PWindowsUserInfo userInfo, PACL *pACL, Error **errp=
)<br>
+{<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Creates a base ACL that both admins and users will s=
hare<br>
+=C2=A0 =C2=A0 =C2=A0* This adds the Administrators group and the SYSTEM gr=
oup<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!create_acl_base(pACL, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* If the user is not an admin give the user creating t=
he key permission to<br>
+=C2=A0 =C2=A0 =C2=A0* access the file.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!userInfo-&gt;isAdmin) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!create_acl_user(userInfo, pACL, errp)) {<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+/*<br>
+ * Create the SSH directory for the user and d sets appropriate permission=
s.<br>
+ * In general the directory will be %PROGRAMDATA%/ssh if the user is an ad=
min.<br>
+ * %USERPOFILE%/.ssh if not an admin<br>
+ *<br>
+ * parameters:<br>
+ * userInfo -&gt; Contains information about the user<br>
+ * errp -&gt; Structure that will contain errors if the function fails.<br=
>
+ * returns: zero upon failure, 1 upon success<br>
+ */<br>
+static bool create_ssh_directory(WindowsUserInfo *userInfo, Error **errp)<=
br>
+{<br>
+=C2=A0 =C2=A0 PACL pNewACL =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree PSECURITY_DESCRIPTOR pSD =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /* Gets the appropriate ACL for the user */<br>
+=C2=A0 =C2=A0 if (!create_acl(userInfo, &amp;pNewACL, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Allocate memory for a security descriptor */<br>
+=C2=A0 =C2=A0 pSD =3D g_malloc(SECURITY_DESCRIPTOR_MIN_LENGTH);<br>
+=C2=A0 =C2=A0 if (!InitializeSecurityDescriptor(pSD, SECURITY_DESCRIPTOR_R=
EVISION)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;Failed to initialize security descriptor&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Associate the security descriptor with the ACL permission=
s. */<br>
+=C2=A0 =C2=A0 if (!SetSecurityDescriptorDacl(pSD, TRUE, pNewACL, FALSE)) {=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;Failed to set security descriptor ACL&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Set the security attributes on the folder */<br>
+=C2=A0 =C2=A0 SECURITY_ATTRIBUTES sAttr;<br>
+=C2=A0 =C2=A0 sAttr.bInheritHandle =3D FALSE;<br>
+=C2=A0 =C2=A0 sAttr.nLength =3D sizeof(SECURITY_ATTRIBUTES);<br>
+=C2=A0 =C2=A0 sAttr.lpSecurityDescriptor =3D pSD;<br>
+<br>
+=C2=A0 =C2=A0 /* Create the directory with the created permissions */<br>
+=C2=A0 =C2=A0 BOOL created =3D CreateDirectory(userInfo-&gt;sshDirectory, =
&amp;sAttr);<br>
+=C2=A0 =C2=A0 if (!created) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to create directory %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0userInfo-&gt;sshDirectory);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Free memory */<br>
+=C2=A0 =C2=A0 LocalFree(pNewACL);<br>
+=C2=A0 =C2=A0 return true;<br>
+error:<br>
+=C2=A0 =C2=A0 LocalFree(pNewACL);<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+/*<br>
+ * Sets permissions on the authorized_key_file that is created.<br>
+ *<br>
+ * parameters: userInfo -&gt; Information about the user<br>
+ * errp -&gt; error structure that will contain errors upon failure<br>
+ * returns: 1 upon success, zero upon failure.<br>
+ */<br>
+static bool set_file_permissions(PWindowsUserInfo userInfo, Error **errp)<=
br>
+{<br>
+=C2=A0 =C2=A0 PACL pACL =3D NULL;<br>
+=C2=A0 =C2=A0 PSID userPSID;<br>
+<br>
+=C2=A0 =C2=A0 /* Creates the access control structure */<br>
+=C2=A0 =C2=A0 if (!create_acl(userInfo, &amp;pACL, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Get the PSID structure for the user based off the string =
SID. */<br>
+=C2=A0 =C2=A0 bool converted =3D ConvertStringSidToSid(userInfo-&gt;SSID, =
&amp;userPSID);<br>
+=C2=A0 =C2=A0 if (!converted) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to retrieve user %s SID&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0userInfo-&gt;username);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Prevents permissions from being inherited and use the DAC=
L provided. */<br>
+=C2=A0 =C2=A0 const SE_OBJECT_TYPE securityBitFlags =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 DACL_SECURITY_INFORMATION | PROTECTED_DACL_SEC=
URITY_INFORMATION;<br>
+<br>
+=C2=A0 =C2=A0 /* Set the ACL on the file. */<br>
+=C2=A0 =C2=A0 if (SetNamedSecurityInfo(userInfo-&gt;authorizedKeyFile, SE_=
FILE_OBJECT,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0securityBitFlags, userPSID, NULL, pACL,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0NULL) !=3D ERROR_SUCCESS) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;failed to set file security for file %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0userInfo-&gt;authorizedKeyFile);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 LocalFree(pACL);<br>
+=C2=A0 =C2=A0 LocalFree(userPSID);<br>
+=C2=A0 =C2=A0 return true;<br>
+<br>
+error:<br>
+=C2=A0 =C2=A0 LocalFree(pACL);<br>
+=C2=A0 =C2=A0 LocalFree(userPSID);<br>
+<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+/*<br>
+ * Writes the specified keys to the authenticated keys file.<br>
+ * parameters:<br>
+ * userInfo: Information about the user we are writing the authkeys file t=
o.<br>
+ * authkeys: Array of keys to write to disk<br>
+ * errp: Error structure that will contain any errors if they occur.<br>
+ * returns: 1 if successful, 0 otherwise.<br>
+ */<br>
+static bool write_authkeys(WindowsUserInfo *userInfo, GStrv authkeys,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *contents =3D NULL;<br>
+=C2=A0 =C2=A0 g_autoptr(GError) err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 contents =3D g_strjoinv(&quot;\n&quot;, authkeys);<br>
+<br>
+=C2=A0 =C2=A0 if (!g_file_set_contents(userInfo-&gt;authorizedKeyFile, con=
tents, -1, &amp;err)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to write to &#39=
;%s&#39;: %s&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0userI=
nfo-&gt;authorizedKeyFile, err-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!set_file_permissions(userInfo, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+/*<br>
+ * Retrieves information about a Windows user by their username<br>
+ *<br>
+ * parameters:<br>
+ * userInfo -&gt; Double pointer to a WindowsUserInfo structure. Upon succ=
ess, it<br>
+ * will be allocated with information about the user and need to be freed.=
<br>
+ * username -&gt; Name of the user to lookup.<br>
+ * errp -&gt; Contains any errors that occur.<br>
+ * returns: 1 upon success, 0 upon failure.<br>
+ */<br>
+static bool get_user_info(PWindowsUserInfo *userInfo, const char *username=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD infoLevel =3D 4;<br>
+=C2=A0 =C2=A0 LPUSER_INFO_4 uBuf =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree wchar_t *wideUserName =3D NULL;<br>
+=C2=A0 =C2=A0 g_autoptr(GError) gerr =3D NULL;<br>
+=C2=A0 =C2=A0 PSID psid =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Converts a string to a Windows wide string since the=
 GetNetUserInfo<br>
+=C2=A0 =C2=A0 =C2=A0* function requires it.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 wideUserName =3D g_utf8_to_utf16(username, -1, NULL, NULL, &=
amp;gerr);<br>
+=C2=A0 =C2=A0 if (!wideUserName) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* allocate data */<br>
+=C2=A0 =C2=A0 PWindowsUserInfo uData =3D g_new0(WindowsUserInfo, 1);<br>
+<br>
+=C2=A0 =C2=A0 /* Set pointer so it can be cleaned up by the callee, even u=
pon error. */<br>
+=C2=A0 =C2=A0 *userInfo =3D uData;<br>
+<br>
+=C2=A0 =C2=A0 /* Find the information */<br>
+=C2=A0 =C2=A0 NET_API_STATUS result =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NetUserGetInfo(NULL, wideUserName, infoLevel, =
(LPBYTE *)&amp;uBuf);<br>
+=C2=A0 =C2=A0 if (result !=3D NERR_Success) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Give a friendlier error message if the user=
 was not found. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (result =3D=3D NERR_UserNotFound) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;User %s w=
as not found&quot;, username);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;Received unexpected error when asking for user info: Error &quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot=
;Code %lu&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0resul=
t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Get information from the buffer returned by NetUserGetInf=
o. */<br>
+=C2=A0 =C2=A0 uData-&gt;username =3D g_strdup(username);<br>
+=C2=A0 =C2=A0 uData-&gt;isAdmin =3D uBuf-&gt;usri4_priv =3D=3D USER_PRIV_A=
DMIN;<br>
+=C2=A0 =C2=A0 psid =3D uBuf-&gt;usri4_user_sid;<br>
+<br>
+=C2=A0 =C2=A0 char *sidStr =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* We store the string representation of the SID not SI=
D structure in<br>
+=C2=A0 =C2=A0 =C2=A0* memory. Callees wanting to use the SID structure sho=
uld call<br>
+=C2=A0 =C2=A0 =C2=A0* ConvertStringSidToSID.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 if (!ConvertSidToStringSid(psid, &amp;sidStr)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&quot;failed to get SID string for user %s&quot;, username=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Store the SSID */<br>
+=C2=A0 =C2=A0 uData-&gt;SSID =3D sidStr;<br>
+<br>
+=C2=A0 =C2=A0 /* Get the SSH folder for the user. */<br>
+=C2=A0 =C2=A0 char *sshFolder =3D get_ssh_folder(username, uData-&gt;isAdm=
in, errp);<br>
+=C2=A0 =C2=A0 if (sshFolder =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Get the authorized key file path */<br>
+=C2=A0 =C2=A0 const char *authorizedKeyFile =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 uData-&gt;isAdmin ? AUTHORIZED_KEY_FILE_ADMIN =
: AUTHORIZED_KEY_FILE;<br>
+=C2=A0 =C2=A0 char *authorizedKeyPath =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_build_filename(sshFolder, authorizedKeyFile,=
 NULL);<br>
+=C2=A0 =C2=A0 uData-&gt;sshDirectory =3D sshFolder;<br>
+=C2=A0 =C2=A0 uData-&gt;authorizedKeyFile =3D authorizedKeyPath;<br>
+<br>
+=C2=A0 =C2=A0 /* Free */<br>
+=C2=A0 =C2=A0 NetApiBufferFree(uBuf);<br>
+=C2=A0 =C2=A0 return true;<br>
+error:<br>
+=C2=A0 =C2=A0 if (uBuf) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NetApiBufferFree(uBuf);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+/*<br>
+ * Gets the list of authorized keys for a user.<br>
+ *<br>
+ * parameters:<br>
+ * username -&gt; Username to retrieve the keys for.<br>
+ * errp -&gt; Error structure that will display any errors through QMP.<br=
>
+ * returns: List of keys associated with the user.<br>
+ */<br>
+GuestAuthorizedKeys *qmp_guest_ssh_get_authorized_keys(const char *usernam=
e,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestAuthorizedKeys *keys =3D NULL;<br>
+=C2=A0 =C2=A0 g_auto(GStrv) authKeys =3D NULL;<br>
+=C2=A0 =C2=A0 g_autoptr(GuestAuthorizedKeys) ret =3D NULL;<br>
+=C2=A0 =C2=A0 g_auto(PWindowsUserInfo) userInfo =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 /* Gets user information */<br>
+=C2=A0 =C2=A0 if (!get_user_info(&amp;userInfo, username, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Reads authkeys for the user */<br>
+=C2=A0 =C2=A0 authKeys =3D read_authkeys(userInfo-&gt;authorizedKeyFile, e=
rrp);<br>
+=C2=A0 =C2=A0 if (authKeys =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Set the GuestAuthorizedKey struct with keys from the file=
 */<br>
+=C2=A0 =C2=A0 ret =3D g_new0(GuestAuthorizedKeys, 1);<br>
+=C2=A0 =C2=A0 for (int i =3D 0; authKeys[i] !=3D NULL; i++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strstrip(authKeys[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!authKeys[i][0] || authKeys[i][0] =3D=3D &=
#39;#&#39;) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(ret-&gt;keys, g_strdup(authK=
eys[i]));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /*<br>
+=C2=A0 =C2=A0 =C2=A0* Steal the pointer because it is up for the callee to=
 deallocate the<br>
+=C2=A0 =C2=A0 =C2=A0* memory.<br>
+=C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 keys =3D g_steal_pointer(&amp;ret);<br>
+=C2=A0 =C2=A0 return keys;<br>
+}<br>
+<br>
+/*<br>
+ * Adds an ssh key for a user.<br>
+ *<br>
+ * parameters:<br>
+ * username -&gt; User to add the SSH key to<br>
+ * strList -&gt; Array of keys to add to the list<br>
+ * has_reset -&gt; Whether the keys have been reset<br>
+ * reset -&gt; Boolean to reset the keys (If this is set the existing list=
 will be<br>
+ * cleared) and the other key reset. errp -&gt; Pointer to an error struct=
ure that<br>
+ * will get returned over QMP if anything goes wrong.<br>
+ */<br>
+void qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_=
reset, bool reset, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_auto(PWindowsUserInfo) userInfo =3D NULL;<br>
+=C2=A0 =C2=A0 g_auto(GStrv) authkeys =3D NULL;<br>
+=C2=A0 =C2=A0 strList *k;<br>
+=C2=A0 =C2=A0 size_t nkeys, nauthkeys;<br>
+<br>
+=C2=A0 =C2=A0 /* Make sure the keys given are valid */<br>
+=C2=A0 =C2=A0 if (!check_openssh_pub_keys(keys, &amp;nkeys, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Gets user information */<br>
+=C2=A0 =C2=A0 if (!get_user_info(&amp;userInfo, username, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Determine whether we should reset the keys */<br>
+=C2=A0 =C2=A0 reset =3D has_reset &amp;&amp; reset;<br>
+=C2=A0 =C2=A0 if (!reset) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Read existing keys into memory */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 authkeys =3D read_authkeys(userInfo-&gt;author=
izedKeyFile, NULL);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Check that the SSH key directory exists for the user. */<=
br>
+=C2=A0 =C2=A0 if (!g_file_test(userInfo-&gt;sshDirectory, G_FILE_TEST_IS_D=
IR)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 BOOL success =3D create_ssh_directory(userInfo=
, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!success) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Reallocates the buffer to fit the new keys. */<br>
+=C2=A0 =C2=A0 nauthkeys =3D authkeys ? g_strv_length(authkeys) : 0;<br>
+=C2=A0 =C2=A0 authkeys =3D g_realloc_n(authkeys, nauthkeys + nkeys + 1, si=
zeof(char *));<br>
+<br>
+=C2=A0 =C2=A0 /* zero out the memory for the reallocated buffer */<br>
+=C2=A0 =C2=A0 memset(authkeys + nauthkeys, 0, (nkeys + 1) * sizeof(char *)=
);<br>
+<br>
+=C2=A0 =C2=A0 /* Adds the keys */<br>
+=C2=A0 =C2=A0 for (k =3D keys; k !=3D NULL; k =3D k-&gt;next) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Check that the key doesn&#39;t already exis=
t */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strv_contains((const gchar *const *)auth=
keys, k-&gt;value)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 authkeys[nauthkeys++] =3D g_strdup(k-&gt;value=
);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Write the authkeys to the file. */<br>
+=C2=A0 =C2=A0 write_authkeys(userInfo, authkeys, errp);<br>
+}<br>
+<br>
+/*<br>
+ * Removes an SSH key for a user<br>
+ *<br>
+ * parameters:<br>
+ * username -&gt; Username to remove the key from<br>
+ * strList -&gt; List of strings to remove<br>
+ * errp -&gt; Contains any errors that occur.<br>
+ */<br>
+void qmp_guest_ssh_remove_authorized_keys(const char *username, strList *k=
eys,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 E=
rror **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_auto(PWindowsUserInfo) userInfo =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree struct passwd *p =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree GStrv new_keys =3D NULL; /* do not own the string=
s */<br>
+=C2=A0 =C2=A0 g_auto(GStrv) authkeys =3D NULL;<br>
+=C2=A0 =C2=A0 GStrv a;<br>
+=C2=A0 =C2=A0 size_t nkeys =3D 0;<br>
+<br>
+=C2=A0 =C2=A0 /* Validates the keys passed in by the user */<br>
+=C2=A0 =C2=A0 if (!check_openssh_pub_keys(keys, NULL, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Gets user information */<br>
+=C2=A0 =C2=A0 if (!get_user_info(&amp;userInfo, username, errp)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Reads the authkeys for the user */<br>
+=C2=A0 =C2=A0 authkeys =3D read_authkeys(userInfo-&gt;authorizedKeyFile, e=
rrp);<br>
+=C2=A0 =C2=A0 if (authkeys =3D=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Create a new buffer to hold the keys */<br>
+=C2=A0 =C2=A0 new_keys =3D g_new0(char *, g_strv_length(authkeys) + 1);<br=
>
+=C2=A0 =C2=A0 for (a =3D authkeys; *a !=3D NULL; a++) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strList *k;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Filters out keys that are equal to ones the=
 user specified. */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (k =3D keys; k !=3D NULL; k =3D k-&gt;next=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_str_equal(k-&gt;value, *a)=
) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (k !=3D NULL) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_keys[nkeys++] =3D *a;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 /* Write the new authkeys to the file. */<br>
+=C2=A0 =C2=A0 write_authkeys(userInfo, new_keys, errp);<br>
+}<br>
diff --git a/qga/commands-windows-ssh.h b/qga/commands-windows-ssh.h<br>
new file mode 100644<br>
index 0000000000..40ac67c4d9<br>
--- /dev/null<br>
+++ b/qga/commands-windows-ssh.h<br>
@@ -0,0 +1,26 @@<br>
+/*<br>
+ * Header file for commands-windows-ssh.c<br>
+ *<br>
+ * Copyright Schweitzer Engineering Laboratories. 2024<br>
+ *<br>
+ * Authors:<br>
+ *=C2=A0 Aidan Leuck &lt;<a href=3D"mailto:aidan_leuck@selinc.com" target=
=3D"_blank">aidan_leuck@selinc.com</a>&gt;<br>
+ *<br>
+ * This work is licensed under the terms of the GNU GPL, version 2 or late=
r.<br>
+ * See the COPYING file in the top-level directory.<br>
+ */<br>
+<br>
+#include &lt;glib/gstrfuncs.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
+typedef struct WindowsUserInfo {<br>
+=C2=A0 =C2=A0 char *sshDirectory;<br>
+=C2=A0 =C2=A0 char *authorizedKeyFile;<br>
+=C2=A0 =C2=A0 char *username;<br>
+=C2=A0 =C2=A0 char *SSID;<br>
+=C2=A0 =C2=A0 bool isAdmin;<br>
+} WindowsUserInfo;<br>
+<br>
+typedef WindowsUserInfo *PWindowsUserInfo;<br>
+<br>
+void free_userInfo(PWindowsUserInfo info);<br>
+G_DEFINE_AUTO_CLEANUP_FREE_FUNC(PWindowsUserInfo, free_userInfo, NULL);<br=
>
diff --git a/qga/meson.build b/qga/meson.build<br>
index 4c3899751b..d5de492da3 100644<br>
--- a/qga/meson.build<br>
+++ b/qga/meson.build<br>
@@ -73,7 +73,8 @@ if host_os =3D=3D &#39;windows&#39;<br>
=C2=A0 =C2=A0 =C2=A0&#39;channel-win32.c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;commands-win32.c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;service-win32.c&#39;,<br>
-=C2=A0 =C2=A0 &#39;vss-win32.c&#39;<br>
+=C2=A0 =C2=A0 &#39;vss-win32.c&#39;,<br>
+=C2=A0 =C2=A0 &#39;commands-windows-ssh.c&#39;<br>
=C2=A0 =C2=A0))<br>
=C2=A0else<br>
=C2=A0 =C2=A0qga_ss.add(files(<br>
@@ -94,7 +95,7 @@ gen_tlb =3D []<br>
=C2=A0qga_libs =3D []<br>
=C2=A0if host_os =3D=3D &#39;windows&#39;<br>
=C2=A0 =C2=A0qga_libs +=3D [&#39;-lws2_32&#39;, &#39;-lwinmm&#39;, &#39;-lp=
owrprof&#39;, &#39;-lwtsapi32&#39;, &#39;-lwininet&#39;, &#39;-liphlpapi&#3=
9;, &#39;-lnetapi32&#39;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-lsetupapi&#39=
;, &#39;-lcfgmgr32&#39;]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;-lsetupapi&#39=
;, &#39;-lcfgmgr32&#39;, &#39;-luserenv&#39;]<br>
=C2=A0 =C2=A0if have_qga_vss<br>
=C2=A0 =C2=A0 =C2=A0qga_libs +=3D [&#39;-lole32&#39;, &#39;-loleaut32&#39;,=
 &#39;-lshlwapi&#39;, &#39;-lstdc++&#39;, &#39;-Wl,--enable-stdcall-fixup&#=
39;]<br>
=C2=A0 =C2=A0 =C2=A0subdir(&#39;vss-win32&#39;)<br>
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json<br>
index 9554b566a7..a64a6d91cf 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1562,9 +1562,8 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestAuthorizedKeys&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;keys&#39;: [&#39;str&#39;]<br>
-=C2=A0 },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
-<br>
+=C2=A0 }<br>
+}<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-ssh-get-authorized-keys:<br>
@@ -1580,8 +1579,8 @@<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-ssh-get-authorized-keys&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: { &#39;username&#39;: &#39;str&#39; },<br>
-=C2=A0 &#39;returns&#39;: &#39;GuestAuthorizedKeys&#39;,<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;returns&#39;: &#39;GuestAuthorizedKeys&#39;<br>
+}<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-ssh-add-authorized-keys:<br>
@@ -1599,8 +1598,8 @@<br>
=C2=A0# Since: 5.2<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-ssh-add-authorized-keys&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;keys&#39;=
: [&#39;str&#39;], &#39;*reset&#39;: &#39;bool&#39; },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;keys&#39;=
: [&#39;str&#39;], &#39;*reset&#39;: &#39;bool&#39; }<br>
+}<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-ssh-remove-authorized-keys:<br>
@@ -1617,8 +1616,8 @@<br>
=C2=A0# Since: 5.2<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-ssh-remove-authorized-keys&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;keys&#39;=
: [&#39;str&#39;] },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;keys&#39;=
: [&#39;str&#39;] }<br>
+}<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskStats:<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div></div>

--00000000000080d6f90616d4484c--


