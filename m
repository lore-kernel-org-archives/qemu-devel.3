Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF35DC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 12:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmv3O-0002TL-Pz; Wed, 20 Mar 2024 08:28:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rmv3N-0002Sy-6D
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:28:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1rmv3H-00041F-MX
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 08:28:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710937693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AKIVZuCkvgQVT85ZsMiJ+xxOH/KdQYVoCL32tWoEbrE=;
 b=ZoaCFOUL64Ir0zv98wBg3d9yhsMbpDjbZTG9l4ccLRrqBK9/1NdbEkImnFaxX1qcwDkqXq
 6YxYMOPfvOzmCP6exRKxGisZX9wOKBXlGqCyeajXMP6k+o5KQ8BclVRO6GJ85vlmgz1tIk
 wI4QDUwFqx1ZZsoI+QwES9+NrA7Vq3M=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-H0f7c-ooOFKz5Tpclhx08Q-1; Wed, 20 Mar 2024 08:28:11 -0400
X-MC-Unique: H0f7c-ooOFKz5Tpclhx08Q-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-513dda67cbeso3906189e87.3
 for <qemu-devel@nongnu.org>; Wed, 20 Mar 2024 05:28:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710937690; x=1711542490;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AKIVZuCkvgQVT85ZsMiJ+xxOH/KdQYVoCL32tWoEbrE=;
 b=okXdTs2ZsvDtElBh8GOmAaNfl8M1wr5qNwgXmgRoyIgf1chKTEP9Q0ywyjL9m5oj0p
 t2mSlu/bB7bIN2o/G4XwG90mmMCLWr+oTryXzV9QJGUB7nl7NdW2jHN3rPkNwhyodA6Y
 91DfX/9bdc+TtOP/0jbXT5lvtW7YtsPreJRyNjFVDoaiy2MR8BNBm9CrUasn/Av/1wQq
 mt0WH8x3kt2exjFF1A4TWD19v2ZGlP9cXY8tRUXjMrubPJ2WyRt2iFWC5HpcWB1995yf
 JswclvOjFu4J1lvJCd1GU4k14XXOqiXdmc3LdKr0IitsZMwOEU0GkduzJ72DRDQvQ1nz
 CtRg==
X-Gm-Message-State: AOJu0YxkBjuq3b9uZQWS9P7Tc57H141gdyFAzRqaQnISHXIzqzoaoaBw
 fJ+1Xj6St3XEOd9ZyNqmvit8EdoPYRRtVtwCs9C8k9xpaTW97PPaC9209johAPFRS0XS9rTcNj1
 lTaZ+OqlVzISndn5cqfFoszw3hD/35pDHNkVdpVnlha4ZpPHLVAJ1m9zGOdeHzy5rHEZINkSunY
 WUNcXtplRaD+m6t3Uw9h7uYSwxcuY=
X-Received: by 2002:a05:6512:ba4:b0:513:3dc5:cd5f with SMTP id
 b36-20020a0565120ba400b005133dc5cd5fmr14860844lfv.40.1710937689681; 
 Wed, 20 Mar 2024 05:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEcyd4R7ZZCz/+ZGqHPnJYubcbDAVF67bGsJloEn1cwHRTMlo6kpNgsWF/lTw5XKmfUMw1eC/Uj4F6Es129Vw=
X-Received: by 2002:a05:6512:ba4:b0:513:3dc5:cd5f with SMTP id
 b36-20020a0565120ba400b005133dc5cd5fmr14860825lfv.40.1710937689101; Wed, 20
 Mar 2024 05:28:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240319181724.212753-1-aidan_leuck@selinc.com>
In-Reply-To: <20240319181724.212753-1-aidan_leuck@selinc.com>
From: Konstantin Kostiuk <kkostiuk@redhat.com>
Date: Wed, 20 Mar 2024 14:27:57 +0200
Message-ID: <CAPMcbCoDEkxkRuUBBpiu53xLoaTUZQKp+Rfy9QOjk3RKX-h+Dw@mail.gmail.com>
Subject: Re: [PATCH] Implement SSH commands in QEMU GA for Windows
To: aidan_leuck@selinc.com
Cc: qemu-devel@nongnu.org, micheal.roth@amd.com
Content-Type: multipart/alternative; boundary="000000000000312a05061416b93c"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

--000000000000312a05061416b93c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 8:18=E2=80=AFPM <aidan_leuck@selinc.com> wrote:

> From: aidaleuc <aidan_leuck@selinc.com>
>
> Signed-off-by: aidaleuc <aidan_leuck@selinc.com>
> ---
>  qga/commands-posix-ssh.c   |  47 +--
>  qga/commands-ssh-core.c    |  52 +++
>  qga/commands-ssh-core.h    |  20 ++
>  qga/commands-windows-ssh.c | 686 +++++++++++++++++++++++++++++++++++++
>  qga/meson.build            |   6 +-
>  qga/qapi-schema.json       |  20 +-
>  6 files changed, 775 insertions(+), 56 deletions(-)
>  create mode 100644 qga/commands-ssh-core.c
>  create mode 100644 qga/commands-ssh-core.h
>  create mode 100644 qga/commands-windows-ssh.c
>
> diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
> index 236f80de44..7058894007 100644
> --- a/qga/commands-posix-ssh.c
> +++ b/qga/commands-posix-ssh.c
> @@ -11,6 +11,7 @@
>
>  #include "qapi/error.h"
>  #include "qga-qapi-commands.h"
> +#include "commands-ssh-core.h"
>
>  #ifdef QGA_BUILD_UNIT_TEST
>  static struct passwd *
> @@ -80,37 +81,6 @@ mkdir_for_user(const char *path, const struct passwd *=
p,
>      return true;
>  }
>
> -static bool
> -check_openssh_pub_key(const char *key, Error **errp)
> -{
> -    /* simple sanity-check, we may want more? */
> -    if (!key || key[0] =3D=3D '#' || strchr(key, '\n')) {
> -        error_setg(errp, "invalid OpenSSH public key: '%s'", key);
> -        return false;
> -    }
> -
> -    return true;
> -}
> -
> -static bool
> -check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
> -{
> -    size_t n =3D 0;
> -    strList *k;
> -
> -    for (k =3D keys; k !=3D NULL; k =3D k->next) {
> -        if (!check_openssh_pub_key(k->value, errp)) {
> -            return false;
> -        }
> -        n++;
> -    }
> -
> -    if (nkeys) {
> -        *nkeys =3D n;
> -    }
> -    return true;
> -}
> -
>

Creating qga/commands-ssh-core.c and qga/commands-ssh-core.h is a
refactoring
or generalization of existing sources. Please move these changes to
separate commits
and then use it in windows and posix implementation.


>  static bool
>  write_authkeys(const char *path, const GStrv keys,
>                 const struct passwd *p, Error **errp)
> @@ -139,21 +109,6 @@ write_authkeys(const char *path, const GStrv keys,
>      return true;
>  }
>
> -static GStrv
> -read_authkeys(const char *path, Error **errp)
> -{
> -    g_autoptr(GError) err =3D NULL;
> -    g_autofree char *contents =3D NULL;
> -
> -    if (!g_file_get_contents(path, &contents, NULL, &err)) {
> -        error_setg(errp, "failed to read '%s': %s", path, err->message);
> -        return NULL;
> -    }
> -
> -    return g_strsplit(contents, "\n", -1);
> -
> -}
> -
>  void
>  qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
>                                    bool has_reset, bool reset,
> diff --git a/qga/commands-ssh-core.c b/qga/commands-ssh-core.c
> new file mode 100644
> index 0000000000..2c9fca791a
> --- /dev/null
> +++ b/qga/commands-ssh-core.c
> @@ -0,0 +1,52 @@
> +#include "qemu/osdep.h"
> +#include <qga-qapi-types.h>
> +#include <stdbool.h>
> +#include "qapi/error.h"
> +#include "commands-ssh-core.h"
> +
> +GStrv read_authkeys(const char *path, Error **errp)
> +{
> +    g_autoptr(GError) err =3D NULL;
> +    g_autofree char *contents =3D NULL;
> +
> +    if (!g_file_get_contents(path, &contents, NULL, &err))
> +    {
> +        error_setg(errp, "failed to read '%s': %s", path, err->message);
> +        return NULL;
> +    }
> +
> +    return g_strsplit(contents, "\n", -1);
> +}
> +
> +bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
> +{
> +    size_t n =3D 0;
> +    strList *k;
> +
> +    for (k =3D keys; k !=3D NULL; k =3D k->next)
> +    {
> +        if (!check_openssh_pub_key(k->value, errp))
> +        {
> +            return false;
> +        }
> +        n++;
> +    }
> +
> +    if (nkeys)
> +    {
> +        *nkeys =3D n;
> +    }
> +    return true;
> +}
> +
> +bool check_openssh_pub_key(const char *key, Error **errp)
> +{
> +    /* simple sanity-check, we may want more? */
> +    if (!key || key[0] =3D=3D '#' || strchr(key, '\n'))
> +    {
> +        error_setg(errp, "invalid OpenSSH public key: '%s'", key);
> +        return false;
> +    }
> +
> +    return true;
> +}
> \ No newline at end of file
> diff --git a/qga/commands-ssh-core.h b/qga/commands-ssh-core.h
> new file mode 100644
> index 0000000000..b6866cff22
> --- /dev/null
> +++ b/qga/commands-ssh-core.h
> @@ -0,0 +1,20 @@
> +#include <glib/gstrfuncs.h>
> +#include "qemu/osdep.h"
> +
> +GStrv read_authkeys(const char *path, Error **errp);
> +bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp);
> +bool check_openssh_pub_key(const char *key, Error **errp);
> +
> +typedef struct WindowsUserInfo
> +{
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
> \ No newline at end of file
> diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
> new file mode 100644
> index 0000000000..59b9309eff
> --- /dev/null
> +++ b/qga/commands-windows-ssh.c
> @@ -0,0 +1,686 @@
> +/*
> + * QEMU Guest Agent win32-specific command implementations for SSH keys.
> + * The implementation is opinionated and expects the SSH implementation =
to
> + * be OpenSSH.
> + *
> + * Copyright IBM Corp. 2024
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
> +#include <qga-qapi-types.h>
> +#include <stdbool.h>
> +#include "qapi/error.h"
> +#include "qga-qapi-commands.h"
> +#include "lmaccess.h"
> +#include "guest-agent-core.h"
> +#include "lmerr.h"
> +#include "lmapibuf.h"
> +#include "shlobj.h"
> +#include "limits.h"
> +#include "userenv.h"
> +#include "commands-ssh-core.h"
> +#include "sddl.h"
> +#include <aclapi.h>
> +
> +#define MAX_PATH_CHAR MAX_PATH * sizeof(char)
> +#define AUTHORIZED_KEY_FILE "authorized_keys"
> +#define AUTHORIZED_KEY_FILE_ADMIN "administrators_authorized_keys"
> +#define LOCAL_SYSTEM_SID "S-1-5-18"
> +#define ADMIN_SID "S-1-5-32-544"
> +#define USER_COUNT 3
>

Where USER_COUNT is used?


> +
> +// Converts from a standard string to a Windows wide string.
> +// it is a 16-bit wide character used to store Unicode encoded as
> UTF-16LE/
> +// some Windows API functions require this format of the string as
> opposed to just
> +// the normal c char*. This function attempts to convert a standard
> string to
> +// a wide string if it is possible. Some multibyte characters are not
> supported
> +// so it could throw an error.
> +// Read more here:
> +//
> https://learn.microsoft.com/en-us/cpp/cpp/char-wchar-t-char16-t-char32-t?=
view=3Dmsvc-170
> +// parameters:
> +// string - String to convert to a wchar.
> +// errp - Error pointer that will set errors if they are converted
> +// returns - The converted string or NULL if an error occurs.
> +static wchar_t *string_to_wide(const char *string, Error **errp)
> +{
> +    // Get the length of the string + 1 for the NULL terminating
> character.
> +    size_t requiredSize =3D strlen(string) + 1;
> +
> +    // Create memory for the wide string.
> +    wchar_t *wideString =3D g_malloc((requiredSize) * sizeof(wchar_t));
> +    if (!wideString)
> +    {
> +        error_setg(errp, "Failed to allocate memory for wide string.");
> +        return NULL;
> +    }
> +
> +    // Convert to wide string
> +    size_t size =3D mbstowcs(wideString, string, requiredSize);
> +    if (size =3D=3D (size_t)-1)
> +    {
> +        error_setg(errp, "Couldn't convert string to wide string. Invali=
d
> multibyte character encountered");
> +
> +        // Free the allocated memory if we failed to convert the string.
> +        if (wideString)
> +        {
> +            g_free(wideString);
> +        }
> +
> +        return NULL;
> +    }
> +
> +    // Return the pointer back to the user.
> +    return g_steal_pointer(&wideString);
> +}
> +
> +// Frees userInfo structure. This implements the g_auto cleanup
> +// for the structure.
> +void free_userInfo(PWindowsUserInfo info)
> +{
> +    if (info->sshDirectory)
> +    {
> +        g_free(info->sshDirectory);
> +    }
> +    if (info->authorizedKeyFile)
> +    {
> +        g_free(info->authorizedKeyFile);
> +    }
> +    if (info->SSID)
> +    {
> +        LocalFree(info->SSID);
> +    }
> +    if (info->username)
> +    {
> +        g_free(info->username);
> +    }
> +
> +    g_free(info);
> +}
> +
> +// Gets the admin SSH folder for OpenSSH. OpenSSH does not store
> +// the authorized_key file in the users home directory for security
> reasons and instead
> +// stores it at %PROGRAMDATA%/ssh. This function returns the path to tha=
t
> directory
> +// on the users machine
> +// parameters: errp -> error structure to set when an error occurs
> +// returns: The path to the ssh folder in %PROGRAMDATA% or NULl if an
> error occurred.
> +static char *get_admin_ssh_folder(Error **errp)
> +{
> +    // Allocate memory for the program data path
> +    g_autofree char *programDataPath =3D g_malloc(MAX_PATH_CHAR);
> +    char *authkeys_path =3D NULL;
> +    PWSTR pgDataW;
> +
> +    // Get the KnownFolderPath on the machine.
> +    HRESULT folderResult =3D SHGetKnownFolderPath(&FOLDERID_ProgramData,=
 0,
> NULL, &pgDataW);
> +    if (folderResult !=3D S_OK)
> +    {
> +        error_setg(errp, "Failed to retrieve ProgramData folder");
> +        return NULL;
> +    }
> +
> +    // Convert from a wide string back to a standard character string.
> +    size_t writtenBytes =3D wcstombs(programDataPath, pgDataW,
> MAX_PATH_CHAR);
> +
> +    // Free the Windows allocated string.
> +    CoTaskMemFree(pgDataW);
> +    if (writtenBytes =3D=3D (size_t)-1)
> +    {
> +        error_setg(errp, "Failed to convert program data path to char
> string");
> +        return NULL;
> +    }
> +
> +    // Build the path to the file.
> +    authkeys_path =3D g_build_filename(programDataPath, "ssh", NULL);
> +    return authkeys_path;
> +}
> +
> +//  Gets the path to the SSH folder for the specified user. If the user
> is an admin it returns
> +//  the ssh folder located at %PROGRAMDATA%/ssh. If the user is not an
> admin it returns %USERPROFILE%/.ssh
> +//  parameters:
> +//  username -> Username to get the SSH folder for
> +//  isAdmin -> Whether the user is an admin or not
> +//  errp -> Error structure to set any errors that occur.
> +//  returns: path to the ssh folder as a string.
> +
> +static char *get_ssh_folder(const char *username, const bool isAdmin,
> Error **errp)
> +{
> +    if (isAdmin)
> +    {
> +        return get_admin_ssh_folder(errp);
> +    }
> +
> +    // If not an Admin the SSH key is in the user directory.
> +    DWORD maxSize =3D MAX_PATH_CHAR;
> +    g_autofree LPSTR profilesDir =3D g_malloc(maxSize);
> +
> +    // Get the user profile directory on the machine.
> +    BOOL ret =3D GetProfilesDirectory(profilesDir, &maxSize);
> +    if (!ret)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve
> profiles directory");
> +        return NULL;
> +    }
> +
> +    // Builds the filename
> +    return g_build_filename(profilesDir, username, ".ssh", NULL);
> +}
> +
> +// Sets the access control on the authorized_keys file and any ssh
> folders that need
> +// to be created. For administrators the required permissions on the
> file/folders are
> +// that only administrators and the LocalSystem account can access the
> folders.
> +// For normal user accounts only the specified user, LocalSystem and
> Administrators can
> +// have access to the key.
> +// parameters:
> +// userInfo -> pointer to structure that contains information about the
> user
> +// PACL -> pointer to an access control structure that will be set upon
> successful completion of the function.
> +// errp -> error structure that will be set upon error.
> +// returns: 1 upon success 0 upon failure.
> +static bool create_acl(PWindowsUserInfo userInfo, PACL *pACL, Error
> **errp)
>

This function looks so long. I suggest to split it into create_acl_admin
and create_acl_user.


> +{
> +    g_autofree PSECURITY_DESCRIPTOR pSD =3D NULL;
> +    g_autofree PEXPLICIT_ACCESS pExplicitAccess =3D NULL;
> +    PSID systemPSID =3D NULL;
> +    PSID adminPSID =3D NULL;
> +    PSID userPSID =3D NULL;
> +
> +    // If the user is an admin only admins and LocalSystem have access s=
o
> two ACL's
> +    // if the user is not an admin, the user, admin and LocalSystem will
> have access so three ACL's.
> +    int numUsers =3D userInfo->isAdmin ? 2 : 3;
> +
> +    // Allocate memory
> +    pExplicitAccess =3D g_malloc(sizeof(EXPLICIT_ACCESS) * numUsers);
> +
> +    // Zero out the allocated memory.
> +    ZeroMemory(pExplicitAccess, numUsers * sizeof(EXPLICIT_ACCESS));
> +
> +    // If the user is not an admin add the user creating the key or
> folder to the list.
> +    if (!userInfo->isAdmin)
> +    {
> +        // Get a pointer to the internal SID object in Windows
> +        bool converted =3D ConvertStringSidToSid(userInfo->SSID, &userPS=
ID);
> +        if (!converted)
> +        {
> +            error_setg_win32(errp, GetLastError(), "failed to retrieve
> user %s SID", userInfo->username);
> +            goto error;
> +        }
> +
> +        // Set the permissions for the user.
> +        pExplicitAccess[2].grfAccessPermissions =3D GENERIC_ALL;
> +        pExplicitAccess[2].grfAccessMode =3D SET_ACCESS;
> +        pExplicitAccess[2].grfInheritance =3D NO_INHERITANCE;
> +        pExplicitAccess[2].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
> +        pExplicitAccess[2].Trustee.TrusteeType =3D TRUSTEE_IS_USER;
> +        pExplicitAccess[2].Trustee.ptstrName =3D (LPTSTR)userPSID;
> +    }
> +
> +    // Create an entry for the system user.
> +    const char *systemSID =3D LOCAL_SYSTEM_SID;
> +    bool converted =3D ConvertStringSidToSid(systemSID, &systemPSID);
> +    if (!converted)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve syste=
m
> SID");
> +        goto error;
> +    }
> +
> +    // set permissions for system user
> +    pExplicitAccess[0].grfAccessPermissions =3D GENERIC_ALL;
> +    pExplicitAccess[0].grfAccessMode =3D SET_ACCESS;
> +    pExplicitAccess[0].grfInheritance =3D NO_INHERITANCE;
> +    pExplicitAccess[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
> +    pExplicitAccess[0].Trustee.TrusteeType =3D TRUSTEE_IS_USER;
> +    pExplicitAccess[0].Trustee.ptstrName =3D (LPTSTR)systemPSID;
> +
> +    // Create an entry for the admin user.
> +    const char *adminSID =3D ADMIN_SID;
> +    converted =3D ConvertStringSidToSid(adminSID, &adminPSID);
> +    if (!converted)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve Admin
> SID");
> +        goto error;
> +    }
> +
> +    pExplicitAccess[1].grfAccessPermissions =3D GENERIC_ALL;
> +    pExplicitAccess[1].grfAccessMode =3D SET_ACCESS;
> +    pExplicitAccess[1].grfInheritance =3D NO_INHERITANCE;
> +    pExplicitAccess[1].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;
> +    pExplicitAccess[1].Trustee.TrusteeType =3D TRUSTEE_IS_GROUP;
> +    pExplicitAccess[1].Trustee.ptstrName =3D (LPTSTR)adminPSID;
> +
> +    // Put the entries in an ACL object.
> +    PACL pNewACL =3D NULL;
> +    DWORD setResult =3D SetEntriesInAcl(numUsers, pExplicitAccess, NULL,
> &pNewACL);
> +
> +    // Set the user provided pointer to the allocated pointer
> +    *pACL =3D pNewACL;
> +
> +    if (setResult !=3D ERROR_SUCCESS)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to set ACL entrie=
s
> for user %s %lu", userInfo->username, setResult);
> +        goto error;
> +    }
> +
> +    // free memory
> +    LocalFree(systemPSID);
> +    LocalFree(adminPSID);
> +
> +    if (userPSID)
> +    {
> +        LocalFree(userPSID);
> +    }
> +
> +    return true;
> +
> +error:
> +    // On error free memory and return false.
> +    if (systemPSID)
> +    {
> +        LocalFree(systemPSID);
> +    }
> +    if (adminPSID)
> +    {
> +        LocalFree(adminPSID);
> +    }
> +    if (userPSID)
> +    {
> +        LocalFree(userPSID);
> +    }
> +
> +    return false;
> +}
>
+
> +// Create the SSH directory for the user and d sets appropriate
> permissions.
> +// In general the directory will be %PROGRAMDATA%/ssh if the user is an
> admin.
> +// %USERPOFILE%/.ssh if not an admin
> +// parameters:
> +// userInfo -> Contains information about the user
> +// errp -> Structure that will contain errors if the function fails.
> +// returns: zero upon failure, 1 upon success
> +static bool create_ssh_directory(WindowsUserInfo *userInfo, Error **errp=
)
> +{
> +
> +    PACL pNewACL =3D NULL;
> +    g_autofree PSECURITY_DESCRIPTOR pSD =3D NULL;
> +
> +    // Gets the approparite ACL for the user
> +    if (!create_acl(userInfo, &pNewACL, errp))
> +    {
> +        goto error;
> +    }
> +
> +    // Allocate memory for a security descriptor
> +    pSD =3D g_malloc(SECURITY_DESCRIPTOR_MIN_LENGTH);
> +    if (!InitializeSecurityDescriptor(pSD, SECURITY_DESCRIPTOR_REVISION)=
)
> +    {
> +        error_setg_win32(errp, GetLastError(), "Failed to initialize
> security descriptor");
> +        goto error;
> +    }
> +
> +    // Associate the security descriptor with the ACL permissions.
> +    if (!SetSecurityDescriptorDacl(pSD, TRUE, pNewACL, FALSE))
> +    {
> +        error_setg_win32(errp, GetLastError(), "Failed to set security
> descriptor ACL");
> +        goto error;
> +    }
> +
> +    // Set the security attributes on the folder
> +    SECURITY_ATTRIBUTES sAttr;
> +    sAttr.bInheritHandle =3D FALSE;
> +    sAttr.nLength =3D sizeof(SECURITY_ATTRIBUTES);
> +    sAttr.lpSecurityDescriptor =3D pSD;
> +
> +    // Create the directory with the created permissions
> +    BOOL created =3D CreateDirectory(userInfo->sshDirectory, &sAttr);
> +    if (!created)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to create
> directory %s", userInfo->sshDirectory);
> +        goto error;
> +    }
> +
> +    // Free memory
> +    LocalFree(pNewACL);
> +    return true;
> +error:
> +    if (pNewACL)
> +    {
> +        LocalFree(pNewACL);
> +    }
> +
> +    return false;
> +}
> +
> +// Sets permissions on the authorized_key_file that is created.
> +// parameters: userInfo -> Information about the user
> +// errp -> error structure that will contain errors upon failure
> +// returns: 1 upon success, zero upon failure.
> +static bool set_file_permissions(PWindowsUserInfo userInfo, Error **errp=
)
> +{
> +    PACL pACL =3D NULL;
> +    PSID userPSID;
> +
> +    // Creates the access control structure
> +    if (!create_acl(userInfo, &pACL, errp))
> +    {
> +        goto error;
> +    }
> +
> +    // Get the PSID structure for the user based off the string SID.
> +    bool converted =3D ConvertStringSidToSid(userInfo->SSID, &userPSID);
> +    if (!converted)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve user
> %s SID", userInfo->username);
> +        goto error;
> +    }
> +
> +    // Set the ACL on the file.
> +    if (SetNamedSecurityInfo(userInfo->authorizedKeyFile, SE_FILE_OBJECT=
,
> DACL_SECURITY_INFORMATION, userPSID, NULL, pACL, NULL) !=3D ERROR_SUCCESS=
)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to set file
> security for file %s", userInfo->authorizedKeyFile);
> +        goto error;
> +    }
> +
> +    LocalFree(pACL);
> +    LocalFree(userPSID);
> +    return true;
> +
> +error:
> +    if (pACL)
> +    {
> +        LocalFree(pACL);
> +    }
> +    if (userPSID)
> +    {
> +        LocalFree(userPSID);
> +    }
> +    return false;
> +}
> +
> +// Writes the specified keys to the authenticated keys file.
> +// parameters:
> +// userInfo: Information about the user we are writing the authkeys file
> to.
> +// authkeys: Array of keys to write to disk
> +// errp: Error structure that will contain any errors if they occur.
> +// returns: 1 if succesful, 0 otherwise.
> +static bool write_authkeys(WindowsUserInfo *userInfo, GStrv authkeys,
> Error **errp)
> +{
> +    g_autofree char *contents =3D NULL;
> +    g_autoptr(GError) err =3D NULL;
> +
> +    contents =3D g_strjoinv("\n", authkeys);
> +
> +    if (!g_file_set_contents(userInfo->authorizedKeyFile, contents, -1,
> &err))
> +    {
> +        error_setg(errp, "failed to write to '%s': %s",
> userInfo->authorizedKeyFile, err->message);
> +        return false;
> +    }
> +
> +    if (!set_file_permissions(userInfo, errp))
> +    {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
> +// Retrieves information about a Windows user by their username
> +// userInfo -> Double pointer to a WindowsUserInfo structure. Upon
> success, it will be allocated
> +// with information about the user and need to be freed.
> +// username -> Name of the user to lookup.
> +// errp -> Contains any errors that occur.
> +// returns -> 1 upon success, 0 upon failure.
> +static bool get_user_info(PWindowsUserInfo *userInfo, const char
> *username, Error **errp)
> +{
> +    DWORD infoLevel =3D 4;
> +    LPUSER_INFO_4 uBuf =3D NULL;
> +    g_autofree wchar_t *wideUserName =3D NULL;
> +
> +    // Converts a string to a Windows wide string since the GetNetUserIn=
fo
> +    // function requires it.
> +    wideUserName =3D string_to_wide(username, errp);
> +    if (!wideUserName)
> +    {
> +        goto error;
> +    }
> +
> +    // allocate data
> +    PWindowsUserInfo uData =3D g_malloc(sizeof(WindowsUserInfo));
> +
> +    // Set pointer so it can be cleaned up by the calle, even upon error=
.
> +    *userInfo =3D uData;
> +
> +    // Find the information
> +    NET_API_STATUS result =3D NetUserGetInfo(NULL, wideUserName, infoLev=
el,
> (LPBYTE *)&uBuf);
> +    if (result !=3D NERR_Success)
> +    {
> +        // Give a friendlier error message if the user was not found.
> +        if (result =3D=3D NERR_UserNotFound)
> +        {
> +            error_setg(errp, "User %s was not found", username);
> +            goto error;
> +        }
> +
> +        error_setg(errp, "Received unexpected error when asking for user
> info: Error Code %lu", result);
> +        goto error;
> +    }
> +
> +    // Get information from the buffer returned by NetUserGetInfo.
> +    uData->username =3D g_strdup(username);
> +    uData->isAdmin =3D uBuf->usri4_priv =3D=3D USER_PRIV_ADMIN;
> +    PSID psid =3D uBuf->usri4_user_sid;
> +
> +    char *sidStr =3D NULL;
> +
> +    // We store the string representation of the SID not SID structure i=
n
> memory. Callees wanting
> +    // to use the SID structure should call ConvertStringSidToSID.
> +    if (!ConvertSidToStringSid(psid, &sidStr))
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to get SID string
> for user %s", username);
> +        goto error;
> +    }
> +
> +    // Store the SSID
> +    uData->SSID =3D sidStr;
> +
> +    // Get the SSH folder for the user.
> +    char *sshFolder =3D get_ssh_folder(username, uData->isAdmin, errp);
> +    if (sshFolder =3D=3D NULL)
> +    {
> +        goto error;
> +    }
> +
> +    // Get the authorized key file path
> +    const char *authorizedKeyFile =3D uData->isAdmin ?
> AUTHORIZED_KEY_FILE_ADMIN : AUTHORIZED_KEY_FILE;
> +    char *authorizedKeyPath =3D g_build_filename(sshFolder,
> authorizedKeyFile, NULL);
> +
> +    uData->sshDirectory =3D sshFolder;
> +    uData->authorizedKeyFile =3D authorizedKeyPath;
> +
> +    // Free
> +    NetApiBufferFree(uBuf);
> +    return true;
> +error:
> +    if (uBuf)
> +    {
> +        NetApiBufferFree(uBuf);
> +    }
> +
> +    return false;
> +}
> +
> +// Gets the list of authorized keys for a user.
> +// parameters:
> +// username -> Username to retrieve the keys for.
> +// errp -> Error structure that will display any errors through QMP.
> +// returns: List of keys associated with the user.
> +GuestAuthorizedKeys *qmp_guest_ssh_get_authorized_keys(const char
> *username, Error **errp)
> +{
> +    GuestAuthorizedKeys *keys =3D NULL;
> +    g_auto(GStrv) authKeys =3D NULL;
> +    g_autoptr(GuestAuthorizedKeys) ret =3D NULL;
> +    g_auto(PWindowsUserInfo) userInfo =3D NULL;
> +
> +    // Gets user information
> +    if (!get_user_info(&userInfo, username, errp))
> +    {
> +        return NULL;
> +    }
> +
> +    // Reads authekys for the user
> +    authKeys =3D read_authkeys(userInfo->authorizedKeyFile, errp);
> +    if (authKeys =3D=3D NULL)
> +    {
> +        return NULL;
> +    }
> +
> +    // Set the GuestAuthorizedKey struct with keys from the file
> +    ret =3D g_new0(GuestAuthorizedKeys, 1);
> +    for (int i =3D 0; authKeys[i] !=3D NULL; i++)
> +    {
> +        g_strstrip(authKeys[i]);
> +        if (!authKeys[i][0] || authKeys[i][0] =3D=3D '#')
> +        {
> +            continue;
> +        }
> +
> +        QAPI_LIST_PREPEND(ret->keys, g_strdup(authKeys[i]));
> +    }
> +
> +    // Steal the pointer because it is up for the callee to deallocate
> the memory.
> +    keys =3D g_steal_pointer(&ret);
> +    return keys;
> +}
> +
> +// Adds an ssh key for a user.
> +// parameters:
> +// username -> User to add the SSH key to
> +// strList -> Array of keys to add to the list
> +// has_reset -> Whether the keys have been reset
> +// reset -> Boolean to reset the keys (If this is set the existing list
> will be cleared) and the other key reset.
> +// errp -> Pointer to an error structure that will get returned over QMP
> if anything goes wrong.
> +void qmp_guest_ssh_add_authorized_keys(const char *username, strList
> *keys,
> +                                       bool has_reset, bool reset,
> +                                       Error **errp)
> +{
> +    g_auto(PWindowsUserInfo) userInfo =3D NULL;
> +    g_auto(GStrv) authkeys =3D NULL;
> +    strList *k;
> +    size_t nkeys, nauthkeys;
> +
> +    // Make sure the keys given are valid
> +    if (!check_openssh_pub_keys(keys, &nkeys, errp))
> +    {
> +        return;
> +    }
> +
> +    // Gets user information
> +    if (!get_user_info(&userInfo, username, errp))
> +    {
> +        return;
> +    }
> +
> +    // Determine whether we should reset the keys
> +    reset =3D has_reset && reset;
> +    if (!reset)
> +    {
> +        // If we are not resetting the keys, read the existing keys into
> memory
> +        authkeys =3D read_authkeys(userInfo->authorizedKeyFile, NULL);
> +    }
> +
> +    // Check that the SSH key directory exists for the user.
> +    if (!g_file_test(userInfo->sshDirectory, G_FILE_TEST_IS_DIR))
> +    {
> +        BOOL success =3D create_ssh_directory(userInfo, errp);
> +        if (!success)
> +        {
> +            return;
> +        }
> +    }
> +
> +    // Reallocates the buffer to fit the new keys.
> +    nauthkeys =3D authkeys ? g_strv_length(authkeys) : 0;
> +    authkeys =3D g_realloc_n(authkeys, nauthkeys + nkeys + 1, sizeof(cha=
r
> *));
> +
> +    // zero out the memory for the reallocated buffer
> +    memset(authkeys + nauthkeys, 0, (nkeys + 1) * sizeof(char *));
> +
> +    // Adds the keys
> +    for (k =3D keys; k !=3D NULL; k =3D k->next)
> +    {
> +        // Check that the key doesn't already exist
> +        if (g_strv_contains((const gchar *const *)authkeys, k->value))
> +        {
> +            continue;
> +        }
> +
> +        authkeys[nauthkeys++] =3D g_strdup(k->value);
> +    }
> +
> +    // Write the authkeys to the file.
> +    write_authkeys(userInfo, authkeys, errp);
> +}
> +
> +// Removes an SSH key for a user
> +// parameters:
> +// username -> Username to remove the key from
> +// strList -> List of strings to remove
> +// errp -> Contains any errors that occur.
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
> +    // Validates the keys passed in by the user
> +    if (!check_openssh_pub_keys(keys, NULL, errp))
> +    {
> +        return;
> +    }
> +
> +    // Gets user information
> +    if (!get_user_info(&userInfo, username, errp))
> +    {
> +        return;
> +    }
> +
> +    // Reads the authkeys for the user
> +    authkeys =3D read_authkeys(userInfo->authorizedKeyFile, errp);
> +    if (authkeys =3D=3D NULL)
> +    {
> +        return;
> +    }
> +
> +    // Create a new buffer to hold the keys
> +    new_keys =3D g_new0(char *, g_strv_length(authkeys) + 1);
> +    for (a =3D authkeys; *a !=3D NULL; a++)
> +    {
> +        strList *k;
> +
> +        // Filters out keys that are equal to ones the user specified.
> +        for (k =3D keys; k !=3D NULL; k =3D k->next)
> +        {
> +            if (g_str_equal(k->value, *a))
> +            {
> +                break;
> +            }
> +        }
> +
> +        if (k !=3D NULL)
> +        {
> +            continue;
> +        }
> +
> +        new_keys[nkeys++] =3D *a;
> +    }
> +
> +    // Write the new authkeys to the file.
> +    write_authkeys(userInfo, new_keys, errp);
> +}
> \ No newline at end of file
> diff --git a/qga/meson.build b/qga/meson.build
> index 1c3d2a3d1b..e365cd1ed7 100644
> --- a/qga/meson.build
> +++ b/qga/meson.build
> @@ -66,13 +66,15 @@ qga_ss.add(files(
>    'guest-agent-command-state.c',
>    'main.c',
>    'cutils.c',
> +  'commands-ssh-core.c'
>  ))
>  if host_os =3D=3D 'windows'
>    qga_ss.add(files(
>      'channel-win32.c',
>      'commands-win32.c',
>      'service-win32.c',
> -    'vss-win32.c'
> +    'vss-win32.c',
> +    'commands-windows-ssh.c'
>    ))
>  else
>    qga_ss.add(files(
> @@ -93,7 +95,7 @@ gen_tlb =3D []
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
> index 9554b566a7..57dc3ab12d 100644
> --- a/qga/qapi-schema.json
> +++ b/qga/qapi-schema.json
> @@ -1562,8 +1562,8 @@
>  { 'struct': 'GuestAuthorizedKeys',
>    'data': {
>        'keys': ['str']
> -  },
> -  'if': 'CONFIG_POSIX' }
> +  }
> +}
>
>
>  ##
> @@ -1580,8 +1580,8 @@
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
> @@ -1599,8 +1599,10 @@
>  # Since: 5.2
>  ##
>  { 'command': 'guest-ssh-add-authorized-keys',
> -  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' },
> -  'if': 'CONFIG_POSIX' }
> +  'data': { 'username': 'str', 'keys': ['str'
> +    ], '*reset': 'bool'
> +  }
> +}
>
>  ##
>  # @guest-ssh-remove-authorized-keys:
> @@ -1617,8 +1619,10 @@
>  # Since: 5.2
>  ##
>  { 'command': 'guest-ssh-remove-authorized-keys',
> -  'data': { 'username': 'str', 'keys': ['str'] },
> -  'if': 'CONFIG_POSIX' }
> +  'data': { 'username': 'str', 'keys': ['str'
> +    ]
> +  }
> +}
>
>  ##
>  # @GuestDiskStats:
> --
> 2.44.0
>
>

--000000000000312a05061416b93c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br clear=3D"all"><div><div dir=3D"ltr" c=
lass=3D"gmail_signature"><div dir=3D"ltr"><br></div></div></div><br></div><=
br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue,=
 Mar 19, 2024 at 8:18=E2=80=AFPM &lt;<a href=3D"mailto:aidan_leuck@selinc.c=
om">aidan_leuck@selinc.com</a>&gt; wrote:<br></div><blockquote class=3D"gma=
il_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,2=
04,204);padding-left:1ex">From: aidaleuc &lt;<a href=3D"mailto:aidan_leuck@=
selinc.com" target=3D"_blank">aidan_leuck@selinc.com</a>&gt;<br>
<br>
Signed-off-by: aidaleuc &lt;<a href=3D"mailto:aidan_leuck@selinc.com" targe=
t=3D"_blank">aidan_leuck@selinc.com</a>&gt;<br>
---<br>
=C2=A0qga/commands-posix-ssh.c=C2=A0 =C2=A0|=C2=A0 47 +--<br>
=C2=A0qga/commands-ssh-core.c=C2=A0 =C2=A0 |=C2=A0 52 +++<br>
=C2=A0qga/commands-ssh-core.h=C2=A0 =C2=A0 |=C2=A0 20 ++<br>
=C2=A0qga/commands-windows-ssh.c | 686 ++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0qga/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A06 +-<br>
=C2=A0qga/qapi-schema.json=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 20 +-<br>
=C2=A06 files changed, 775 insertions(+), 56 deletions(-)<br>
=C2=A0create mode 100644 qga/commands-ssh-core.c<br>
=C2=A0create mode 100644 qga/commands-ssh-core.h<br>
=C2=A0create mode 100644 qga/commands-windows-ssh.c<br>
<br>
diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c<br>
index 236f80de44..7058894007 100644<br>
--- a/qga/commands-posix-ssh.c<br>
+++ b/qga/commands-posix-ssh.c<br>
@@ -11,6 +11,7 @@<br>
<br>
=C2=A0#include &quot;qapi/error.h&quot;<br>
=C2=A0#include &quot;qga-qapi-commands.h&quot;<br>
+#include &quot;commands-ssh-core.h&quot;<br>
<br>
=C2=A0#ifdef QGA_BUILD_UNIT_TEST<br>
=C2=A0static struct passwd *<br>
@@ -80,37 +81,6 @@ mkdir_for_user(const char *path, const struct passwd *p,=
<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
-static bool<br>
-check_openssh_pub_key(const char *key, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 /* simple sanity-check, we may want more? */<br>
-=C2=A0 =C2=A0 if (!key || key[0] =3D=3D &#39;#&#39; || strchr(key, &#39;\n=
&#39;)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;invalid OpenSSH public =
key: &#39;%s&#39;&quot;, key);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return true;<br>
-}<br>
-<br>
-static bool<br>
-check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 size_t n =3D 0;<br>
-=C2=A0 =C2=A0 strList *k;<br>
-<br>
-=C2=A0 =C2=A0 for (k =3D keys; k !=3D NULL; k =3D k-&gt;next) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!check_openssh_pub_key(k-&gt;value, errp))=
 {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 if (nkeys) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 *nkeys =3D n;<br>
-=C2=A0 =C2=A0 }<br>
-=C2=A0 =C2=A0 return true;<br>
-}<br>
-<br></blockquote><div><br></div><div>Creating qga/commands-ssh-core.c and =
qga/commands-ssh-core.h is a refactoring</div><div>or generalization of exi=
sting sources. Please move these changes to separate commits</div><div>and =
then use it in windows and posix implementation.<br></div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0static bool<br>
=C2=A0write_authkeys(const char *path, const GStrv keys,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct passwd=
 *p, Error **errp)<br>
@@ -139,21 +109,6 @@ write_authkeys(const char *path, const GStrv keys,<br>
=C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0}<br>
<br>
-static GStrv<br>
-read_authkeys(const char *path, Error **errp)<br>
-{<br>
-=C2=A0 =C2=A0 g_autoptr(GError) err =3D NULL;<br>
-=C2=A0 =C2=A0 g_autofree char *contents =3D NULL;<br>
-<br>
-=C2=A0 =C2=A0 if (!g_file_get_contents(path, &amp;contents, NULL, &amp;err=
)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to read &#39;%s&=
#39;: %s&quot;, path, err-&gt;message);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
-=C2=A0 =C2=A0 }<br>
-<br>
-=C2=A0 =C2=A0 return g_strsplit(contents, &quot;\n&quot;, -1);<br>
-<br>
-}<br>
-<br>
=C2=A0void<br>
=C2=A0qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys=
,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_reset, bool re=
set,<br>
diff --git a/qga/commands-ssh-core.c b/qga/commands-ssh-core.c<br>
new file mode 100644<br>
index 0000000000..2c9fca791a<br>
--- /dev/null<br>
+++ b/qga/commands-ssh-core.c<br>
@@ -0,0 +1,52 @@<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &lt;qga-qapi-types.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;commands-ssh-core.h&quot;<br>
+<br>
+GStrv read_authkeys(const char *path, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_autoptr(GError) err =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree char *contents =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 if (!g_file_get_contents(path, &amp;contents, NULL, &amp;err=
))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to read &#39;%s&=
#39;: %s&quot;, path, err-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return g_strsplit(contents, &quot;\n&quot;, -1);<br>
+}<br>
+<br>
+bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)<br=
>
+{<br>
+=C2=A0 =C2=A0 size_t n =3D 0;<br>
+=C2=A0 =C2=A0 strList *k;<br>
+<br>
+=C2=A0 =C2=A0 for (k =3D keys; k !=3D NULL; k =3D k-&gt;next)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!check_openssh_pub_key(k-&gt;value, errp))=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 n++;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (nkeys)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 *nkeys =3D n;<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+bool check_openssh_pub_key(const char *key, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 /* simple sanity-check, we may want more? */<br>
+=C2=A0 =C2=A0 if (!key || key[0] =3D=3D &#39;#&#39; || strchr(key, &#39;\n=
&#39;))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;invalid OpenSSH public =
key: &#39;%s&#39;&quot;, key);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
\ No newline at end of file<br>
diff --git a/qga/commands-ssh-core.h b/qga/commands-ssh-core.h<br>
new file mode 100644<br>
index 0000000000..b6866cff22<br>
--- /dev/null<br>
+++ b/qga/commands-ssh-core.h<br>
@@ -0,0 +1,20 @@<br>
+#include &lt;glib/gstrfuncs.h&gt;<br>
+#include &quot;qemu/osdep.h&quot;<br>
+<br>
+GStrv read_authkeys(const char *path, Error **errp);<br>
+bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp);<b=
r>
+bool check_openssh_pub_key(const char *key, Error **errp);<br>
+<br>
+typedef struct WindowsUserInfo<br>
+{<br>
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
\ No newline at end of file<br>
diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c<br>
new file mode 100644<br>
index 0000000000..59b9309eff<br>
--- /dev/null<br>
+++ b/qga/commands-windows-ssh.c<br>
@@ -0,0 +1,686 @@<br>
+/*<br>
+ * QEMU Guest Agent win32-specific command implementations for SSH keys.<b=
r>
+ * The implementation is opinionated and expects the SSH implementation to=
<br>
+ * be OpenSSH.<br>
+ *<br>
+ * Copyright IBM Corp. 2024<br>
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
+#include &lt;qga-qapi-types.h&gt;<br>
+#include &lt;stdbool.h&gt;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;qga-qapi-commands.h&quot;<br>
+#include &quot;lmaccess.h&quot;<br>
+#include &quot;guest-agent-core.h&quot;<br>
+#include &quot;lmerr.h&quot;<br>
+#include &quot;lmapibuf.h&quot;<br>
+#include &quot;shlobj.h&quot;<br>
+#include &quot;limits.h&quot;<br>
+#include &quot;userenv.h&quot;<br>
+#include &quot;commands-ssh-core.h&quot;<br>
+#include &quot;sddl.h&quot;<br>
+#include &lt;aclapi.h&gt;<br>
+<br>
+#define MAX_PATH_CHAR MAX_PATH * sizeof(char)<br>
+#define AUTHORIZED_KEY_FILE &quot;authorized_keys&quot;<br>
+#define AUTHORIZED_KEY_FILE_ADMIN &quot;administrators_authorized_keys&quo=
t;<br>
+#define LOCAL_SYSTEM_SID &quot;S-1-5-18&quot;<br>
+#define ADMIN_SID &quot;S-1-5-32-544&quot;<br>
+#define USER_COUNT 3<br></blockquote><div><br></div><div>Where USER_COUNT =
is used? <br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
+<br>
+// Converts from a standard string to a Windows wide string.<br>
+// it is a 16-bit wide character used to store Unicode encoded as UTF-16LE=
/<br>
+// some Windows API functions require this format of the string as opposed=
 to just<br>
+// the normal c char*. This function attempts to convert a standard string=
 to<br>
+// a wide string if it is possible. Some multibyte characters are not supp=
orted<br>
+// so it could throw an error.<br>
+// Read more here:<br>
+// <a href=3D"https://learn.microsoft.com/en-us/cpp/cpp/char-wchar-t-char1=
6-t-char32-t?view=3Dmsvc-170" rel=3D"noreferrer" target=3D"_blank">https://=
learn.microsoft.com/en-us/cpp/cpp/char-wchar-t-char16-t-char32-t?view=3Dmsv=
c-170</a><br>
+// parameters:<br>
+// string - String to convert to a wchar.<br>
+// errp - Error pointer that will set errors if they are converted<br>
+// returns - The converted string or NULL if an error occurs.<br>
+static wchar_t *string_to_wide(const char *string, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 // Get the length of the string + 1 for the NULL terminating=
 character.<br>
+=C2=A0 =C2=A0 size_t requiredSize =3D strlen(string) + 1;<br>
+<br>
+=C2=A0 =C2=A0 // Create memory for the wide string.<br>
+=C2=A0 =C2=A0 wchar_t *wideString =3D g_malloc((requiredSize) * sizeof(wch=
ar_t));<br>
+=C2=A0 =C2=A0 if (!wideString)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to allocate memo=
ry for wide string.&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Convert to wide string<br>
+=C2=A0 =C2=A0 size_t size =3D mbstowcs(wideString, string, requiredSize);<=
br>
+=C2=A0 =C2=A0 if (size =3D=3D (size_t)-1)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Couldn&#39;t convert st=
ring to wide string. Invalid multibyte character encountered&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Free the allocated memory if we failed to c=
onvert the string.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (wideString)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(wideString);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Return the pointer back to the user.<br>
+=C2=A0 =C2=A0 return g_steal_pointer(&amp;wideString);<br>
+}<br>
+<br>
+// Frees userInfo structure. This implements the g_auto cleanup<br>
+// for the structure.<br>
+void free_userInfo(PWindowsUserInfo info)<br>
+{<br>
+=C2=A0 =C2=A0 if (info-&gt;sshDirectory)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(info-&gt;sshDirectory);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (info-&gt;authorizedKeyFile)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(info-&gt;authorizedKeyFile);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (info-&gt;SSID)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 LocalFree(info-&gt;SSID);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (info-&gt;username)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(info-&gt;username);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 g_free(info);<br>
+}<br>
+<br>
+// Gets the admin SSH folder for OpenSSH. OpenSSH does not store<br>
+// the authorized_key file in the users home directory for security reason=
s and instead<br>
+// stores it at %PROGRAMDATA%/ssh. This function returns the path to that =
directory<br>
+// on the users machine<br>
+// parameters: errp -&gt; error structure to set when an error occurs<br>
+// returns: The path to the ssh folder in %PROGRAMDATA% or NULl if an erro=
r occurred.<br>
+static char *get_admin_ssh_folder(Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 // Allocate memory for the program data path<br>
+=C2=A0 =C2=A0 g_autofree char *programDataPath =3D g_malloc(MAX_PATH_CHAR)=
;<br>
+=C2=A0 =C2=A0 char *authkeys_path =3D NULL;<br>
+=C2=A0 =C2=A0 PWSTR pgDataW;<br>
+<br>
+=C2=A0 =C2=A0 // Get the KnownFolderPath on the machine.<br>
+=C2=A0 =C2=A0 HRESULT folderResult =3D SHGetKnownFolderPath(&amp;FOLDERID_=
ProgramData, 0, NULL, &amp;pgDataW);<br>
+=C2=A0 =C2=A0 if (folderResult !=3D S_OK)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to retrieve Prog=
ramData folder&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Convert from a wide string back to a standard character s=
tring.<br>
+=C2=A0 =C2=A0 size_t writtenBytes =3D wcstombs(programDataPath, pgDataW, M=
AX_PATH_CHAR);<br>
+<br>
+=C2=A0 =C2=A0 // Free the Windows allocated string.<br>
+=C2=A0 =C2=A0 CoTaskMemFree(pgDataW);<br>
+=C2=A0 =C2=A0 if (writtenBytes =3D=3D (size_t)-1)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Failed to convert progr=
am data path to char string&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Build the path to the file.<br>
+=C2=A0 =C2=A0 authkeys_path =3D g_build_filename(programDataPath, &quot;ss=
h&quot;, NULL);<br>
+=C2=A0 =C2=A0 return authkeys_path;<br>
+}<br>
+<br>
+//=C2=A0 Gets the path to the SSH folder for the specified user. If the us=
er is an admin it returns<br>
+//=C2=A0 the ssh folder located at %PROGRAMDATA%/ssh. If the user is not a=
n admin it returns %USERPROFILE%/.ssh<br>
+//=C2=A0 parameters:<br>
+//=C2=A0 username -&gt; Username to get the SSH folder for<br>
+//=C2=A0 isAdmin -&gt; Whether the user is an admin or not<br>
+//=C2=A0 errp -&gt; Error structure to set any errors that occur.<br>
+//=C2=A0 returns: path to the ssh folder as a string.<br>
+<br>
+static char *get_ssh_folder(const char *username, const bool isAdmin, Erro=
r **errp)<br>
+{<br>
+=C2=A0 =C2=A0 if (isAdmin)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return get_admin_ssh_folder(errp);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // If not an Admin the SSH key is in the user directory.<br>
+=C2=A0 =C2=A0 DWORD maxSize =3D MAX_PATH_CHAR;<br>
+=C2=A0 =C2=A0 g_autofree LPSTR profilesDir =3D g_malloc(maxSize);<br>
+<br>
+=C2=A0 =C2=A0 // Get the user profile directory on the machine.<br>
+=C2=A0 =C2=A0 BOOL ret =3D GetProfilesDirectory(profilesDir, &amp;maxSize)=
;<br>
+=C2=A0 =C2=A0 if (!ret)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to retrieve profiles directory&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Builds the filename<br>
+=C2=A0 =C2=A0 return g_build_filename(profilesDir, username, &quot;.ssh&qu=
ot;, NULL);<br>
+}<br>
+<br>
+// Sets the access control on the authorized_keys file and any ssh folders=
 that need<br>
+// to be created. For administrators the required permissions on the file/=
folders are<br>
+// that only administrators and the LocalSystem account can access the fol=
ders.<br>
+// For normal user accounts only the specified user, LocalSystem and Admin=
istrators can<br>
+// have access to the key.<br>
+// parameters:<br>
+// userInfo -&gt; pointer to structure that contains information about the=
 user<br>
+// PACL -&gt; pointer to an access control structure that will be set upon=
 successful completion of the function.<br>
+// errp -&gt; error structure that will be set upon error.<br>
+// returns: 1 upon success 0 upon failure.<br>
+static bool create_acl(PWindowsUserInfo userInfo, PACL *pACL, Error **errp=
)<br></blockquote><div><br></div><div>This function looks so long. I sugges=
t to split it into create_acl_admin and create_acl_user.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
+{<br>
+=C2=A0 =C2=A0 g_autofree PSECURITY_DESCRIPTOR pSD =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree PEXPLICIT_ACCESS pExplicitAccess =3D NULL;<br>
+=C2=A0 =C2=A0 PSID systemPSID =3D NULL;<br>
+=C2=A0 =C2=A0 PSID adminPSID =3D NULL;<br>
+=C2=A0 =C2=A0 PSID userPSID =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 // If the user is an admin only admins and LocalSystem have =
access so two ACL&#39;s<br>
+=C2=A0 =C2=A0 // if the user is not an admin, the user, admin and LocalSys=
tem will have access so three ACL&#39;s.<br>
+=C2=A0 =C2=A0 int numUsers =3D userInfo-&gt;isAdmin ? 2 : 3;<br>
+<br>
+=C2=A0 =C2=A0 // Allocate memory<br>
+=C2=A0 =C2=A0 pExplicitAccess =3D g_malloc(sizeof(EXPLICIT_ACCESS) * numUs=
ers);<br>
+<br>
+=C2=A0 =C2=A0 // Zero out the allocated memory.<br>
+=C2=A0 =C2=A0 ZeroMemory(pExplicitAccess, numUsers * sizeof(EXPLICIT_ACCES=
S));<br>
+<br>
+=C2=A0 =C2=A0 // If the user is not an admin add the user creating the key=
 or folder to the list.<br>
+=C2=A0 =C2=A0 if (!userInfo-&gt;isAdmin)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Get a pointer to the internal SID object in=
 Windows<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool converted =3D ConvertStringSidToSid(userI=
nfo-&gt;SSID, &amp;userPSID);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!converted)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastEr=
ror(), &quot;failed to retrieve user %s SID&quot;, userInfo-&gt;username);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Set the permissions for the user.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pExplicitAccess[2].grfAccessPermissions =3D GE=
NERIC_ALL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pExplicitAccess[2].grfAccessMode =3D SET_ACCES=
S;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pExplicitAccess[2].grfInheritance =3D NO_INHER=
ITANCE;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pExplicitAccess[2].Trustee.TrusteeForm =3D TRU=
STEE_IS_SID;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pExplicitAccess[2].Trustee.TrusteeType =3D TRU=
STEE_IS_USER;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 pExplicitAccess[2].Trustee.ptstrName =3D (LPTS=
TR)userPSID;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Create an entry for the system user.<br>
+=C2=A0 =C2=A0 const char *systemSID =3D LOCAL_SYSTEM_SID;<br>
+=C2=A0 =C2=A0 bool converted =3D ConvertStringSidToSid(systemSID, &amp;sys=
temPSID);<br>
+=C2=A0 =C2=A0 if (!converted)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to retrieve system SID&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // set permissions for system user<br>
+=C2=A0 =C2=A0 pExplicitAccess[0].grfAccessPermissions =3D GENERIC_ALL;<br>
+=C2=A0 =C2=A0 pExplicitAccess[0].grfAccessMode =3D SET_ACCESS;<br>
+=C2=A0 =C2=A0 pExplicitAccess[0].grfInheritance =3D NO_INHERITANCE;<br>
+=C2=A0 =C2=A0 pExplicitAccess[0].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;<b=
r>
+=C2=A0 =C2=A0 pExplicitAccess[0].Trustee.TrusteeType =3D TRUSTEE_IS_USER;<=
br>
+=C2=A0 =C2=A0 pExplicitAccess[0].Trustee.ptstrName =3D (LPTSTR)systemPSID;=
<br>
+<br>
+=C2=A0 =C2=A0 // Create an entry for the admin user.<br>
+=C2=A0 =C2=A0 const char *adminSID =3D ADMIN_SID;<br>
+=C2=A0 =C2=A0 converted =3D ConvertStringSidToSid(adminSID, &amp;adminPSID=
);<br>
+=C2=A0 =C2=A0 if (!converted)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to retrieve Admin SID&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 pExplicitAccess[1].grfAccessPermissions =3D GENERIC_ALL;<br>
+=C2=A0 =C2=A0 pExplicitAccess[1].grfAccessMode =3D SET_ACCESS;<br>
+=C2=A0 =C2=A0 pExplicitAccess[1].grfInheritance =3D NO_INHERITANCE;<br>
+=C2=A0 =C2=A0 pExplicitAccess[1].Trustee.TrusteeForm =3D TRUSTEE_IS_SID;<b=
r>
+=C2=A0 =C2=A0 pExplicitAccess[1].Trustee.TrusteeType =3D TRUSTEE_IS_GROUP;=
<br>
+=C2=A0 =C2=A0 pExplicitAccess[1].Trustee.ptstrName =3D (LPTSTR)adminPSID;<=
br>
+<br>
+=C2=A0 =C2=A0 // Put the entries in an ACL object.<br>
+=C2=A0 =C2=A0 PACL pNewACL =3D NULL;<br>
+=C2=A0 =C2=A0 DWORD setResult =3D SetEntriesInAcl(numUsers, pExplicitAcces=
s, NULL, &amp;pNewACL);<br>
+<br>
+=C2=A0 =C2=A0 // Set the user provided pointer to the allocated pointer<br=
>
+=C2=A0 =C2=A0 *pACL =3D pNewACL;<br>
+<br>
+=C2=A0 =C2=A0 if (setResult !=3D ERROR_SUCCESS)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to set ACL entries for user %s %lu&quot;, userInfo-&gt;username, setR=
esult);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // free memory<br>
+=C2=A0 =C2=A0 LocalFree(systemPSID);<br>
+=C2=A0 =C2=A0 LocalFree(adminPSID);<br>
+<br>
+=C2=A0 =C2=A0 if (userPSID)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 LocalFree(userPSID);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+<br>
+error:<br>
+=C2=A0 =C2=A0 // On error free memory and return false.<br>
+=C2=A0 =C2=A0 if (systemPSID)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 LocalFree(systemPSID);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (adminPSID)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 LocalFree(adminPSID);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (userPSID)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 LocalFree(userPSID);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br></blockquote><blockquote class=3D"gmail_quote" style=3D"margin:0px 0p=
x 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
+<br>
+// Create the SSH directory for the user and d sets appropriate permission=
s.<br>
+// In general the directory will be %PROGRAMDATA%/ssh if the user is an ad=
min.<br>
+// %USERPOFILE%/.ssh if not an admin<br>
+// parameters:<br>
+// userInfo -&gt; Contains information about the user<br>
+// errp -&gt; Structure that will contain errors if the function fails.<br=
>
+// returns: zero upon failure, 1 upon success<br>
+static bool create_ssh_directory(WindowsUserInfo *userInfo, Error **errp)<=
br>
+{<br>
+<br>
+=C2=A0 =C2=A0 PACL pNewACL =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree PSECURITY_DESCRIPTOR pSD =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 // Gets the approparite ACL for the user<br>
+=C2=A0 =C2=A0 if (!create_acl(userInfo, &amp;pNewACL, errp))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Allocate memory for a security descriptor<br>
+=C2=A0 =C2=A0 pSD =3D g_malloc(SECURITY_DESCRIPTOR_MIN_LENGTH);<br>
+=C2=A0 =C2=A0 if (!InitializeSecurityDescriptor(pSD, SECURITY_DESCRIPTOR_R=
EVISION))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;F=
ailed to initialize security descriptor&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Associate the security descriptor with the ACL permission=
s.<br>
+=C2=A0 =C2=A0 if (!SetSecurityDescriptorDacl(pSD, TRUE, pNewACL, FALSE))<b=
r>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;F=
ailed to set security descriptor ACL&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Set the security attributes on the folder<br>
+=C2=A0 =C2=A0 SECURITY_ATTRIBUTES sAttr;<br>
+=C2=A0 =C2=A0 sAttr.bInheritHandle =3D FALSE;<br>
+=C2=A0 =C2=A0 sAttr.nLength =3D sizeof(SECURITY_ATTRIBUTES);<br>
+=C2=A0 =C2=A0 sAttr.lpSecurityDescriptor =3D pSD;<br>
+<br>
+=C2=A0 =C2=A0 // Create the directory with the created permissions<br>
+=C2=A0 =C2=A0 BOOL created =3D CreateDirectory(userInfo-&gt;sshDirectory, =
&amp;sAttr);<br>
+=C2=A0 =C2=A0 if (!created)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to create directory %s&quot;, userInfo-&gt;sshDirectory);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Free memory<br>
+=C2=A0 =C2=A0 LocalFree(pNewACL);<br>
+=C2=A0 =C2=A0 return true;<br>
+error:<br>
+=C2=A0 =C2=A0 if (pNewACL)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 LocalFree(pNewACL);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+// Sets permissions on the authorized_key_file that is created.<br>
+// parameters: userInfo -&gt; Information about the user<br>
+// errp -&gt; error structure that will contain errors upon failure<br>
+// returns: 1 upon success, zero upon failure.<br>
+static bool set_file_permissions(PWindowsUserInfo userInfo, Error **errp)<=
br>
+{<br>
+=C2=A0 =C2=A0 PACL pACL =3D NULL;<br>
+=C2=A0 =C2=A0 PSID userPSID;<br>
+<br>
+=C2=A0 =C2=A0 // Creates the access control structure<br>
+=C2=A0 =C2=A0 if (!create_acl(userInfo, &amp;pACL, errp))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Get the PSID structure for the user based off the string =
SID.<br>
+=C2=A0 =C2=A0 bool converted =3D ConvertStringSidToSid(userInfo-&gt;SSID, =
&amp;userPSID);<br>
+=C2=A0 =C2=A0 if (!converted)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to retrieve user %s SID&quot;, userInfo-&gt;username);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Set the ACL on the file.<br>
+=C2=A0 =C2=A0 if (SetNamedSecurityInfo(userInfo-&gt;authorizedKeyFile, SE_=
FILE_OBJECT, DACL_SECURITY_INFORMATION, userPSID, NULL, pACL, NULL) !=3D ER=
ROR_SUCCESS)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to set file security for file %s&quot;, userInfo-&gt;authorizedKeyFil=
e);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 LocalFree(pACL);<br>
+=C2=A0 =C2=A0 LocalFree(userPSID);<br>
+=C2=A0 =C2=A0 return true;<br>
+<br>
+error:<br>
+=C2=A0 =C2=A0 if (pACL)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 LocalFree(pACL);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 if (userPSID)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 LocalFree(userPSID);<br>
+=C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+// Writes the specified keys to the authenticated keys file.<br>
+// parameters:<br>
+// userInfo: Information about the user we are writing the authkeys file t=
o.<br>
+// authkeys: Array of keys to write to disk<br>
+// errp: Error structure that will contain any errors if they occur.<br>
+// returns: 1 if succesful, 0 otherwise.<br>
+static bool write_authkeys(WindowsUserInfo *userInfo, GStrv authkeys, Erro=
r **errp)<br>
+{<br>
+=C2=A0 =C2=A0 g_autofree char *contents =3D NULL;<br>
+=C2=A0 =C2=A0 g_autoptr(GError) err =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 contents =3D g_strjoinv(&quot;\n&quot;, authkeys);<br>
+<br>
+=C2=A0 =C2=A0 if (!g_file_set_contents(userInfo-&gt;authorizedKeyFile, con=
tents, -1, &amp;err))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;failed to write to &#39=
;%s&#39;: %s&quot;, userInfo-&gt;authorizedKeyFile, err-&gt;message);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 if (!set_file_permissions(userInfo, errp))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return true;<br>
+}<br>
+<br>
+// Retrieves information about a Windows user by their username<br>
+// userInfo -&gt; Double pointer to a WindowsUserInfo structure. Upon succ=
ess, it will be allocated<br>
+// with information about the user and need to be freed.<br>
+// username -&gt; Name of the user to lookup.<br>
+// errp -&gt; Contains any errors that occur.<br>
+// returns -&gt; 1 upon success, 0 upon failure.<br>
+static bool get_user_info(PWindowsUserInfo *userInfo, const char *username=
, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 DWORD infoLevel =3D 4;<br>
+=C2=A0 =C2=A0 LPUSER_INFO_4 uBuf =3D NULL;<br>
+=C2=A0 =C2=A0 g_autofree wchar_t *wideUserName =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 // Converts a string to a Windows wide string since the GetN=
etUserInfo<br>
+=C2=A0 =C2=A0 // function requires it.<br>
+=C2=A0 =C2=A0 wideUserName =3D string_to_wide(username, errp);<br>
+=C2=A0 =C2=A0 if (!wideUserName)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // allocate data<br>
+=C2=A0 =C2=A0 PWindowsUserInfo uData =3D g_malloc(sizeof(WindowsUserInfo))=
;<br>
+<br>
+=C2=A0 =C2=A0 // Set pointer so it can be cleaned up by the calle, even up=
on error.<br>
+=C2=A0 =C2=A0 *userInfo =3D uData;<br>
+<br>
+=C2=A0 =C2=A0 // Find the information<br>
+=C2=A0 =C2=A0 NET_API_STATUS result =3D NetUserGetInfo(NULL, wideUserName,=
 infoLevel, (LPBYTE *)&amp;uBuf);<br>
+=C2=A0 =C2=A0 if (result !=3D NERR_Success)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Give a friendlier error message if the user=
 was not found.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (result =3D=3D NERR_UserNotFound)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;User %s w=
as not found&quot;, username);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg(errp, &quot;Received unexpected err=
or when asking for user info: Error Code %lu&quot;, result);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Get information from the buffer returned by NetUserGetInf=
o.<br>
+=C2=A0 =C2=A0 uData-&gt;username =3D g_strdup(username);<br>
+=C2=A0 =C2=A0 uData-&gt;isAdmin =3D uBuf-&gt;usri4_priv =3D=3D USER_PRIV_A=
DMIN;<br>
+=C2=A0 =C2=A0 PSID psid =3D uBuf-&gt;usri4_user_sid;<br>
+<br>
+=C2=A0 =C2=A0 char *sidStr =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 // We store the string representation of the SID not SID str=
ucture in memory. Callees wanting<br>
+=C2=A0 =C2=A0 // to use the SID structure should call ConvertStringSidToSI=
D.<br>
+=C2=A0 =C2=A0 if (!ConvertSidToStringSid(psid, &amp;sidStr))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_setg_win32(errp, GetLastError(), &quot;f=
ailed to get SID string for user %s&quot;, username);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Store the SSID<br>
+=C2=A0 =C2=A0 uData-&gt;SSID =3D sidStr;<br>
+<br>
+=C2=A0 =C2=A0 // Get the SSH folder for the user.<br>
+=C2=A0 =C2=A0 char *sshFolder =3D get_ssh_folder(username, uData-&gt;isAdm=
in, errp);<br>
+=C2=A0 =C2=A0 if (sshFolder =3D=3D NULL)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Get the authorized key file path<br>
+=C2=A0 =C2=A0 const char *authorizedKeyFile =3D uData-&gt;isAdmin ? AUTHOR=
IZED_KEY_FILE_ADMIN : AUTHORIZED_KEY_FILE;<br>
+=C2=A0 =C2=A0 char *authorizedKeyPath =3D g_build_filename(sshFolder, auth=
orizedKeyFile, NULL);<br>
+<br>
+=C2=A0 =C2=A0 uData-&gt;sshDirectory =3D sshFolder;<br>
+=C2=A0 =C2=A0 uData-&gt;authorizedKeyFile =3D authorizedKeyPath;<br>
+<br>
+=C2=A0 =C2=A0 // Free<br>
+=C2=A0 =C2=A0 NetApiBufferFree(uBuf);<br>
+=C2=A0 =C2=A0 return true;<br>
+error:<br>
+=C2=A0 =C2=A0 if (uBuf)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 NetApiBufferFree(uBuf);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 return false;<br>
+}<br>
+<br>
+// Gets the list of authorized keys for a user.<br>
+// parameters:<br>
+// username -&gt; Username to retrieve the keys for.<br>
+// errp -&gt; Error structure that will display any errors through QMP.<br=
>
+// returns: List of keys associated with the user.<br>
+GuestAuthorizedKeys *qmp_guest_ssh_get_authorized_keys(const char *usernam=
e, Error **errp)<br>
+{<br>
+=C2=A0 =C2=A0 GuestAuthorizedKeys *keys =3D NULL;<br>
+=C2=A0 =C2=A0 g_auto(GStrv) authKeys =3D NULL;<br>
+=C2=A0 =C2=A0 g_autoptr(GuestAuthorizedKeys) ret =3D NULL;<br>
+=C2=A0 =C2=A0 g_auto(PWindowsUserInfo) userInfo =3D NULL;<br>
+<br>
+=C2=A0 =C2=A0 // Gets user information<br>
+=C2=A0 =C2=A0 if (!get_user_info(&amp;userInfo, username, errp))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Reads authekys for the user<br>
+=C2=A0 =C2=A0 authKeys =3D read_authkeys(userInfo-&gt;authorizedKeyFile, e=
rrp);<br>
+=C2=A0 =C2=A0 if (authKeys =3D=3D NULL)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Set the GuestAuthorizedKey struct with keys from the file=
<br>
+=C2=A0 =C2=A0 ret =3D g_new0(GuestAuthorizedKeys, 1);<br>
+=C2=A0 =C2=A0 for (int i =3D 0; authKeys[i] !=3D NULL; i++)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 g_strstrip(authKeys[i]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!authKeys[i][0] || authKeys[i][0] =3D=3D &=
#39;#&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 QAPI_LIST_PREPEND(ret-&gt;keys, g_strdup(authK=
eys[i]));<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Steal the pointer because it is up for the callee to deal=
locate the memory.<br>
+=C2=A0 =C2=A0 keys =3D g_steal_pointer(&amp;ret);<br>
+=C2=A0 =C2=A0 return keys;<br>
+}<br>
+<br>
+// Adds an ssh key for a user.<br>
+// parameters:<br>
+// username -&gt; User to add the SSH key to<br>
+// strList -&gt; Array of keys to add to the list<br>
+// has_reset -&gt; Whether the keys have been reset<br>
+// reset -&gt; Boolean to reset the keys (If this is set the existing list=
 will be cleared) and the other key reset.<br>
+// errp -&gt; Pointer to an error structure that will get returned over QM=
P if anything goes wrong.<br>
+void qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys=
,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool has_=
reset, bool reset,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Error **e=
rrp)<br>
+{<br>
+=C2=A0 =C2=A0 g_auto(PWindowsUserInfo) userInfo =3D NULL;<br>
+=C2=A0 =C2=A0 g_auto(GStrv) authkeys =3D NULL;<br>
+=C2=A0 =C2=A0 strList *k;<br>
+=C2=A0 =C2=A0 size_t nkeys, nauthkeys;<br>
+<br>
+=C2=A0 =C2=A0 // Make sure the keys given are valid<br>
+=C2=A0 =C2=A0 if (!check_openssh_pub_keys(keys, &amp;nkeys, errp))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Gets user information<br>
+=C2=A0 =C2=A0 if (!get_user_info(&amp;userInfo, username, errp))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Determine whether we should reset the keys<br>
+=C2=A0 =C2=A0 reset =3D has_reset &amp;&amp; reset;<br>
+=C2=A0 =C2=A0 if (!reset)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // If we are not resetting the keys, read the =
existing keys into memory<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 authkeys =3D read_authkeys(userInfo-&gt;author=
izedKeyFile, NULL);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Check that the SSH key directory exists for the user.<br>
+=C2=A0 =C2=A0 if (!g_file_test(userInfo-&gt;sshDirectory, G_FILE_TEST_IS_D=
IR))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 BOOL success =3D create_ssh_directory(userInfo=
, errp);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!success)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Reallocates the buffer to fit the new keys.<br>
+=C2=A0 =C2=A0 nauthkeys =3D authkeys ? g_strv_length(authkeys) : 0;<br>
+=C2=A0 =C2=A0 authkeys =3D g_realloc_n(authkeys, nauthkeys + nkeys + 1, si=
zeof(char *));<br>
+<br>
+=C2=A0 =C2=A0 // zero out the memory for the reallocated buffer<br>
+=C2=A0 =C2=A0 memset(authkeys + nauthkeys, 0, (nkeys + 1) * sizeof(char *)=
);<br>
+<br>
+=C2=A0 =C2=A0 // Adds the keys<br>
+=C2=A0 =C2=A0 for (k =3D keys; k !=3D NULL; k =3D k-&gt;next)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Check that the key doesn&#39;t already exis=
t<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_strv_contains((const gchar *const *)auth=
keys, k-&gt;value))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 authkeys[nauthkeys++] =3D g_strdup(k-&gt;value=
);<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Write the authkeys to the file.<br>
+=C2=A0 =C2=A0 write_authkeys(userInfo, authkeys, errp);<br>
+}<br>
+<br>
+// Removes an SSH key for a user<br>
+// parameters:<br>
+// username -&gt; Username to remove the key from<br>
+// strList -&gt; List of strings to remove<br>
+// errp -&gt; Contains any errors that occur.<br>
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
+=C2=A0 =C2=A0 // Validates the keys passed in by the user<br>
+=C2=A0 =C2=A0 if (!check_openssh_pub_keys(keys, NULL, errp))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Gets user information<br>
+=C2=A0 =C2=A0 if (!get_user_info(&amp;userInfo, username, errp))<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Reads the authkeys for the user<br>
+=C2=A0 =C2=A0 authkeys =3D read_authkeys(userInfo-&gt;authorizedKeyFile, e=
rrp);<br>
+=C2=A0 =C2=A0 if (authkeys =3D=3D NULL)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Create a new buffer to hold the keys<br>
+=C2=A0 =C2=A0 new_keys =3D g_new0(char *, g_strv_length(authkeys) + 1);<br=
>
+=C2=A0 =C2=A0 for (a =3D authkeys; *a !=3D NULL; a++)<br>
+=C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 strList *k;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 // Filters out keys that are equal to ones the=
 user specified.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (k =3D keys; k !=3D NULL; k =3D k-&gt;next=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (g_str_equal(k-&gt;value, *a)=
)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (k !=3D NULL)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 new_keys[nkeys++] =3D *a;<br>
+=C2=A0 =C2=A0 }<br>
+<br>
+=C2=A0 =C2=A0 // Write the new authkeys to the file.<br>
+=C2=A0 =C2=A0 write_authkeys(userInfo, new_keys, errp);<br>
+}<br>
\ No newline at end of file<br>
diff --git a/qga/meson.build b/qga/meson.build<br>
index 1c3d2a3d1b..e365cd1ed7 100644<br>
--- a/qga/meson.build<br>
+++ b/qga/meson.build<br>
@@ -66,13 +66,15 @@ qga_ss.add(files(<br>
=C2=A0 =C2=A0&#39;guest-agent-command-state.c&#39;,<br>
=C2=A0 =C2=A0&#39;main.c&#39;,<br>
=C2=A0 =C2=A0&#39;cutils.c&#39;,<br>
+=C2=A0 &#39;commands-ssh-core.c&#39;<br>
=C2=A0))<br>
=C2=A0if host_os =3D=3D &#39;windows&#39;<br>
=C2=A0 =C2=A0qga_ss.add(files(<br>
=C2=A0 =C2=A0 =C2=A0&#39;channel-win32.c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;commands-win32.c&#39;,<br>
=C2=A0 =C2=A0 =C2=A0&#39;service-win32.c&#39;,<br>
-=C2=A0 =C2=A0 &#39;vss-win32.c&#39;<br>
+=C2=A0 =C2=A0 &#39;vss-win32.c&#39;,<br>
+=C2=A0 =C2=A0 &#39;commands-windows-ssh.c&#39;<br>
=C2=A0 =C2=A0))<br>
=C2=A0else<br>
=C2=A0 =C2=A0qga_ss.add(files(<br>
@@ -93,7 +95,7 @@ gen_tlb =3D []<br>
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
index 9554b566a7..57dc3ab12d 100644<br>
--- a/qga/qapi-schema.json<br>
+++ b/qga/qapi-schema.json<br>
@@ -1562,8 +1562,8 @@<br>
=C2=A0{ &#39;struct&#39;: &#39;GuestAuthorizedKeys&#39;,<br>
=C2=A0 =C2=A0&#39;data&#39;: {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;keys&#39;: [&#39;str&#39;]<br>
-=C2=A0 },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 }<br>
+}<br>
<br>
<br>
=C2=A0##<br>
@@ -1580,8 +1580,8 @@<br>
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
@@ -1599,8 +1599,10 @@<br>
=C2=A0# Since: 5.2<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-ssh-add-authorized-keys&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;keys&#39;=
: [&#39;str&#39;], &#39;*reset&#39;: &#39;bool&#39; },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;keys&#39;=
: [&#39;str&#39;<br>
+=C2=A0 =C2=A0 ], &#39;*reset&#39;: &#39;bool&#39;<br>
+=C2=A0 }<br>
+}<br>
<br>
=C2=A0##<br>
=C2=A0# @guest-ssh-remove-authorized-keys:<br>
@@ -1617,8 +1619,10 @@<br>
=C2=A0# Since: 5.2<br>
=C2=A0##<br>
=C2=A0{ &#39;command&#39;: &#39;guest-ssh-remove-authorized-keys&#39;,<br>
-=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;keys&#39;=
: [&#39;str&#39;] },<br>
-=C2=A0 &#39;if&#39;: &#39;CONFIG_POSIX&#39; }<br>
+=C2=A0 &#39;data&#39;: { &#39;username&#39;: &#39;str&#39;, &#39;keys&#39;=
: [&#39;str&#39;<br>
+=C2=A0 =C2=A0 ]<br>
+=C2=A0 }<br>
+}<br>
<br>
=C2=A0##<br>
=C2=A0# @GuestDiskStats:<br>
-- <br>
2.44.0<br>
<br>
</blockquote></div></div>

--000000000000312a05061416b93c--


