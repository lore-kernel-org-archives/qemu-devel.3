Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC0D2C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 11:07:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmtmG-0007ph-EI; Wed, 20 Mar 2024 07:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmtlw-0007nC-F7
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:06:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rmtlo-00055Z-AD
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 07:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710932767;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ZKajsufuUQWZqIkOsrWMWvCxoTo0czAMT9h8Tndg3TI=;
 b=SNkih5VNrCyS+D/FxC2EDPY3wL9nics9ts1eY5j5oqSmbtvr3sP4ugBFp1RmqFCSlJTKUi
 xWU9lBQs+dIkTKpsezIIgZ4Vd4fdAeM4YVNZ1O4XS9BMl9Tyf7KtWH+VJiLTPmuRjT49Xy
 CZh7UkpDfrpw4fZR5QvCMjtOdRUnIFY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-kT0sVB18O-qdYZb7w3r_aw-1; Wed, 20 Mar 2024 07:06:05 -0400
X-MC-Unique: kT0sVB18O-qdYZb7w3r_aw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E856385A58B;
 Wed, 20 Mar 2024 11:06:04 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.205])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 92E1A1C060A4;
 Wed, 20 Mar 2024 11:06:00 +0000 (UTC)
Date: Wed, 20 Mar 2024 11:05:53 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: aidan_leuck@selinc.com
Cc: qemu-devel@nongnu.org, micheal.roth@amd.com, kkostiuk@redhat.com
Subject: Re: [PATCH] Implement SSH commands in QEMU GA for Windows
Message-ID: <ZfrDEUdU6KH9Wnfm@redhat.com>
References: <20240319181724.212753-1-aidan_leuck@selinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319181724.212753-1-aidan_leuck@selinc.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 19, 2024 at 06:17:24PM +0000, aidan_leuck@selinc.com wrote:
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
> @@ -80,37 +81,6 @@ mkdir_for_user(const char *path, const struct passwd *p,
>      return true;
>  }
>  
> -static bool
> -check_openssh_pub_key(const char *key, Error **errp)
> -{
> -    /* simple sanity-check, we may want more? */
> -    if (!key || key[0] == '#' || strchr(key, '\n')) {
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
> -    size_t n = 0;
> -    strList *k;
> -
> -    for (k = keys; k != NULL; k = k->next) {
> -        if (!check_openssh_pub_key(k->value, errp)) {
> -            return false;
> -        }
> -        n++;
> -    }
> -
> -    if (nkeys) {
> -        *nkeys = n;
> -    }
> -    return true;
> -}
> -
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
> -    g_autoptr(GError) err = NULL;
> -    g_autofree char *contents = NULL;
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

This needs to have a license header matching the file you moved the
code out of.

> +#include "qemu/osdep.h"
> +#include <qga-qapi-types.h>
> +#include <stdbool.h>
> +#include "qapi/error.h"
> +#include "commands-ssh-core.h"
> +
> +GStrv read_authkeys(const char *path, Error **errp)
> +{
> +    g_autoptr(GError) err = NULL;
> +    g_autofree char *contents = NULL;
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
> +    size_t n = 0;
> +    strList *k;
> +
> +    for (k = keys; k != NULL; k = k->next)
> +    {
> +        if (!check_openssh_pub_key(k->value, errp))
> +        {

More typical QEMU style is for the '{' to be on the same lnie
as the for/if/while/etc. Only with functions do we put the
'{' on its own line.

> +            return false;
> +        }
> +        n++;
> +    }
> +
> +    if (nkeys)
> +    {
> +        *nkeys = n;
> +    }
> +    return true;
> +}
> +
> +bool check_openssh_pub_key(const char *key, Error **errp)
> +{
> +    /* simple sanity-check, we may want more? */
> +    if (!key || key[0] == '#' || strchr(key, '\n'))
> +    {
> +        error_setg(errp, "invalid OpenSSH public key: '%s'", key);
> +        return false;
> +    }
> +
> +    return true;
> +}
> \ No newline at end of file

Please include the trailing newline here and the header.

> diff --git a/qga/commands-ssh-core.h b/qga/commands-ssh-core.h
> new file mode 100644
> index 0000000000..b6866cff22
> --- /dev/null
> +++ b/qga/commands-ssh-core.h
> @@ -0,0 +1,20 @@

Also needs a license header.

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


It is good practice for code movement / refactoring to be done
in a separate patch from newly added functionality. So this
would benefit from being split into a series of 2 patches.

> diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
> new file mode 100644
> index 0000000000..59b9309eff
> --- /dev/null
> +++ b/qga/commands-windows-ssh.c
> @@ -0,0 +1,686 @@
> +/*
> + * QEMU Guest Agent win32-specific command implementations for SSH keys.
> + * The implementation is opinionated and expects the SSH implementation to
> + * be OpenSSH.
> + *
> + * Copyright IBM Corp. 2024
> + *
> + * Authors:
> + *  Aidan Leuck <aidan_leuck@selinc.com>

Your email address is @selinc.com, but you're indicating the code
is Copyright IBM, which is a mismatch, and thus raises eyebrows.
Can you clarify the situation here.

> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
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

This feels overkill since sizeof(char) is always going to be 1 on
any platform QEMU targets.

> +#define AUTHORIZED_KEY_FILE "authorized_keys"
> +#define AUTHORIZED_KEY_FILE_ADMIN "administrators_authorized_keys"
> +#define LOCAL_SYSTEM_SID "S-1-5-18"
> +#define ADMIN_SID "S-1-5-32-544"
> +#define USER_COUNT 3
> +
> +// Converts from a standard string to a Windows wide string.
> +// it is a 16-bit wide character used to store Unicode encoded as UTF-16LE/
> +// some Windows API functions require this format of the string as opposed to just
> +// the normal c char*. This function attempts to convert a standard string to
> +// a wide string if it is possible. Some multibyte characters are not supported
> +// so it could throw an error.
> +// Read more here:
> +// https://learn.microsoft.com/en-us/cpp/cpp/char-wchar-t-char16-t-char32-t?view=msvc-170
> +// parameters:
> +// string - String to convert to a wchar.
> +// errp - Error pointer that will set errors if they are converted
> +// returns - The converted string or NULL if an error occurs.

Please use C style comments

  /*
   *
   ...
   *
   */

> +static wchar_t *string_to_wide(const char *string, Error **errp)
> +{
> +    // Get the length of the string + 1 for the NULL terminating character.
> +    size_t requiredSize = strlen(string) + 1;
> +
> +    // Create memory for the wide string.
> +    wchar_t *wideString = g_malloc((requiredSize) * sizeof(wchar_t));

Use g_new0 for allocating arrays, as that does a checks for
multiplication overflows on the allocation size.

> +    if (!wideString)
> +    {
> +        error_setg(errp, "Failed to allocate memory for wide string.");
> +        return NULL;
> +    }

g_malloc / g_new will never fail, so this is redundant.

> +
> +    // Convert to wide string
> +    size_t size = mbstowcs(wideString, string, requiredSize);
> +    if (size == (size_t)-1)
> +    {
> +        error_setg(errp, "Couldn't convert string to wide string. Invalid multibyte character encountered");
> +
> +        // Free the allocated memory if we failed to convert the string.
> +        if (wideString)
> +        {
> +            g_free(wideString);
> +        }

g_free accepts NULL, so the conditional check is redundant.

Even better though, would be

   g_autofree wchar_t *wideString = ....

which automatically free's the string on exit except
where you have the g_steal_pointer call.

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

The if conditions around g_free are redundant.

According to

https://learn.microsoft.com/en-us/windows/win32/api/winbase/nf-winbase-localfree

  "If the hMem parameter is NULL, LocalFree ignores the parameter and returns NULL."

so it does not appear you need an 'if' check around LocaFree either.

> +
> +    g_free(info);
> +}
> +
> +// Gets the admin SSH folder for OpenSSH. OpenSSH does not store
> +// the authorized_key file in the users home directory for security reasons and instead
> +// stores it at %PROGRAMDATA%/ssh. This function returns the path to that directory
> +// on the users machine
> +// parameters: errp -> error structure to set when an error occurs
> +// returns: The path to the ssh folder in %PROGRAMDATA% or NULl if an error occurred.
> +static char *get_admin_ssh_folder(Error **errp)
> +{
> +    // Allocate memory for the program data path
> +    g_autofree char *programDataPath = g_malloc(MAX_PATH_CHAR);
> +    char *authkeys_path = NULL;
> +    PWSTR pgDataW;
> +
> +    // Get the KnownFolderPath on the machine.
> +    HRESULT folderResult = SHGetKnownFolderPath(&FOLDERID_ProgramData, 0, NULL, &pgDataW);
> +    if (folderResult != S_OK)
> +    {
> +        error_setg(errp, "Failed to retrieve ProgramData folder");
> +        return NULL;
> +    }
> +
> +    // Convert from a wide string back to a standard character string.
> +    size_t writtenBytes = wcstombs(programDataPath, pgDataW, MAX_PATH_CHAR);
> +
> +    // Free the Windows allocated string.
> +    CoTaskMemFree(pgDataW);
> +    if (writtenBytes == (size_t)-1)
> +    {
> +        error_setg(errp, "Failed to convert program data path to char string");
> +        return NULL;
> +    }
> +
> +    // Build the path to the file.
> +    authkeys_path = g_build_filename(programDataPath, "ssh", NULL);
> +    return authkeys_path;
> +}
> +
> +//  Gets the path to the SSH folder for the specified user. If the user is an admin it returns
> +//  the ssh folder located at %PROGRAMDATA%/ssh. If the user is not an admin it returns %USERPROFILE%/.ssh
> +//  parameters:
> +//  username -> Username to get the SSH folder for
> +//  isAdmin -> Whether the user is an admin or not
> +//  errp -> Error structure to set any errors that occur.
> +//  returns: path to the ssh folder as a string.
> +
> +static char *get_ssh_folder(const char *username, const bool isAdmin, Error **errp)
> +{
> +    if (isAdmin)
> +    {
> +        return get_admin_ssh_folder(errp);
> +    }
> +
> +    // If not an Admin the SSH key is in the user directory.
> +    DWORD maxSize = MAX_PATH_CHAR;
> +    g_autofree LPSTR profilesDir = g_malloc(maxSize);

QEMU would typically use  g_new0(maxSize, 1)

> +
> +    // Get the user profile directory on the machine.
> +    BOOL ret = GetProfilesDirectory(profilesDir, &maxSize);
> +    if (!ret)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve profiles directory");
> +        return NULL;
> +    }
> +
> +    // Builds the filename
> +    return g_build_filename(profilesDir, username, ".ssh", NULL);
> +}
> +
> +// Sets the access control on the authorized_keys file and any ssh folders that need
> +// to be created. For administrators the required permissions on the file/folders are
> +// that only administrators and the LocalSystem account can access the folders.
> +// For normal user accounts only the specified user, LocalSystem and Administrators can
> +// have access to the key.
> +// parameters:
> +// userInfo -> pointer to structure that contains information about the user
> +// PACL -> pointer to an access control structure that will be set upon successful completion of the function.
> +// errp -> error structure that will be set upon error.
> +// returns: 1 upon success 0 upon failure.
> +static bool create_acl(PWindowsUserInfo userInfo, PACL *pACL, Error **errp)
> +{
> +    g_autofree PSECURITY_DESCRIPTOR pSD = NULL;
> +    g_autofree PEXPLICIT_ACCESS pExplicitAccess = NULL;
> +    PSID systemPSID = NULL;
> +    PSID adminPSID = NULL;
> +    PSID userPSID = NULL;
> +
> +    // If the user is an admin only admins and LocalSystem have access so two ACL's
> +    // if the user is not an admin, the user, admin and LocalSystem will have access so three ACL's.
> +    int numUsers = userInfo->isAdmin ? 2 : 3;
> +
> +    // Allocate memory
> +    pExplicitAccess = g_malloc(sizeof(EXPLICIT_ACCESS) * numUsers);

g_new0 here

> +
> +    // Zero out the allocated memory.
> +    ZeroMemory(pExplicitAccess, numUsers * sizeof(EXPLICIT_ACCESS));

Redundant with g_new0, as it will zero out memory already.

> +
> +    // If the user is not an admin add the user creating the key or folder to the list.
> +    if (!userInfo->isAdmin)
> +    {
> +        // Get a pointer to the internal SID object in Windows
> +        bool converted = ConvertStringSidToSid(userInfo->SSID, &userPSID);
> +        if (!converted)
> +        {
> +            error_setg_win32(errp, GetLastError(), "failed to retrieve user %s SID", userInfo->username);
> +            goto error;
> +        }
> +
> +        // Set the permissions for the user.
> +        pExplicitAccess[2].grfAccessPermissions = GENERIC_ALL;
> +        pExplicitAccess[2].grfAccessMode = SET_ACCESS;
> +        pExplicitAccess[2].grfInheritance = NO_INHERITANCE;
> +        pExplicitAccess[2].Trustee.TrusteeForm = TRUSTEE_IS_SID;
> +        pExplicitAccess[2].Trustee.TrusteeType = TRUSTEE_IS_USER;
> +        pExplicitAccess[2].Trustee.ptstrName = (LPTSTR)userPSID;
> +    }
> +
> +    // Create an entry for the system user.
> +    const char *systemSID = LOCAL_SYSTEM_SID;
> +    bool converted = ConvertStringSidToSid(systemSID, &systemPSID);
> +    if (!converted)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve system SID");
> +        goto error;
> +    }
> +
> +    // set permissions for system user
> +    pExplicitAccess[0].grfAccessPermissions = GENERIC_ALL;
> +    pExplicitAccess[0].grfAccessMode = SET_ACCESS;
> +    pExplicitAccess[0].grfInheritance = NO_INHERITANCE;
> +    pExplicitAccess[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
> +    pExplicitAccess[0].Trustee.TrusteeType = TRUSTEE_IS_USER;
> +    pExplicitAccess[0].Trustee.ptstrName = (LPTSTR)systemPSID;
> +
> +    // Create an entry for the admin user.
> +    const char *adminSID = ADMIN_SID;
> +    converted = ConvertStringSidToSid(adminSID, &adminPSID);
> +    if (!converted)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve Admin SID");
> +        goto error;
> +    }
> +
> +    pExplicitAccess[1].grfAccessPermissions = GENERIC_ALL;
> +    pExplicitAccess[1].grfAccessMode = SET_ACCESS;
> +    pExplicitAccess[1].grfInheritance = NO_INHERITANCE;
> +    pExplicitAccess[1].Trustee.TrusteeForm = TRUSTEE_IS_SID;
> +    pExplicitAccess[1].Trustee.TrusteeType = TRUSTEE_IS_GROUP;
> +    pExplicitAccess[1].Trustee.ptstrName = (LPTSTR)adminPSID;
> +
> +    // Put the entries in an ACL object.
> +    PACL pNewACL = NULL;
> +    DWORD setResult = SetEntriesInAcl(numUsers, pExplicitAccess, NULL, &pNewACL);
> +
> +    // Set the user provided pointer to the allocated pointer
> +    *pACL = pNewACL;
> +
> +    if (setResult != ERROR_SUCCESS)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to set ACL entries for user %s %lu", userInfo->username, setResult);
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

Redundant conditions.

> +
> +    return false;
> +}
> +
> +// Create the SSH directory for the user and d sets appropriate permissions.
> +// In general the directory will be %PROGRAMDATA%/ssh if the user is an admin.
> +// %USERPOFILE%/.ssh if not an admin
> +// parameters:
> +// userInfo -> Contains information about the user
> +// errp -> Structure that will contain errors if the function fails.
> +// returns: zero upon failure, 1 upon success
> +static bool create_ssh_directory(WindowsUserInfo *userInfo, Error **errp)
> +{
> +
> +    PACL pNewACL = NULL;
> +    g_autofree PSECURITY_DESCRIPTOR pSD = NULL;
> +
> +    // Gets the approparite ACL for the user
> +    if (!create_acl(userInfo, &pNewACL, errp))
> +    {
> +        goto error;
> +    }
> +
> +    // Allocate memory for a security descriptor
> +    pSD = g_malloc(SECURITY_DESCRIPTOR_MIN_LENGTH);
> +    if (!InitializeSecurityDescriptor(pSD, SECURITY_DESCRIPTOR_REVISION))
> +    {
> +        error_setg_win32(errp, GetLastError(), "Failed to initialize security descriptor");
> +        goto error;
> +    }
> +
> +    // Associate the security descriptor with the ACL permissions.
> +    if (!SetSecurityDescriptorDacl(pSD, TRUE, pNewACL, FALSE))
> +    {
> +        error_setg_win32(errp, GetLastError(), "Failed to set security descriptor ACL");
> +        goto error;
> +    }
> +
> +    // Set the security attributes on the folder
> +    SECURITY_ATTRIBUTES sAttr;
> +    sAttr.bInheritHandle = FALSE;
> +    sAttr.nLength = sizeof(SECURITY_ATTRIBUTES);
> +    sAttr.lpSecurityDescriptor = pSD;
> +
> +    // Create the directory with the created permissions
> +    BOOL created = CreateDirectory(userInfo->sshDirectory, &sAttr);
> +    if (!created)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to create directory %s", userInfo->sshDirectory);
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
> +static bool set_file_permissions(PWindowsUserInfo userInfo, Error **errp)
> +{
> +    PACL pACL = NULL;
> +    PSID userPSID;
> +
> +    // Creates the access control structure
> +    if (!create_acl(userInfo, &pACL, errp))
> +    {
> +        goto error;
> +    }
> +
> +    // Get the PSID structure for the user based off the string SID.
> +    bool converted = ConvertStringSidToSid(userInfo->SSID, &userPSID);
> +    if (!converted)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to retrieve user %s SID", userInfo->username);
> +        goto error;
> +    }
> +
> +    // Set the ACL on the file.
> +    if (SetNamedSecurityInfo(userInfo->authorizedKeyFile, SE_FILE_OBJECT, DACL_SECURITY_INFORMATION, userPSID, NULL, pACL, NULL) != ERROR_SUCCESS)
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to set file security for file %s", userInfo->authorizedKeyFile);
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
> +// userInfo: Information about the user we are writing the authkeys file to.
> +// authkeys: Array of keys to write to disk
> +// errp: Error structure that will contain any errors if they occur.
> +// returns: 1 if succesful, 0 otherwise.
> +static bool write_authkeys(WindowsUserInfo *userInfo, GStrv authkeys, Error **errp)
> +{
> +    g_autofree char *contents = NULL;
> +    g_autoptr(GError) err = NULL;
> +
> +    contents = g_strjoinv("\n", authkeys);
> +
> +    if (!g_file_set_contents(userInfo->authorizedKeyFile, contents, -1, &err))
> +    {
> +        error_setg(errp, "failed to write to '%s': %s", userInfo->authorizedKeyFile, err->message);
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
> +// userInfo -> Double pointer to a WindowsUserInfo structure. Upon success, it will be allocated
> +// with information about the user and need to be freed.
> +// username -> Name of the user to lookup.
> +// errp -> Contains any errors that occur.
> +// returns -> 1 upon success, 0 upon failure.
> +static bool get_user_info(PWindowsUserInfo *userInfo, const char *username, Error **errp)
> +{
> +    DWORD infoLevel = 4;
> +    LPUSER_INFO_4 uBuf = NULL;
> +    g_autofree wchar_t *wideUserName = NULL;
> +
> +    // Converts a string to a Windows wide string since the GetNetUserInfo
> +    // function requires it.
> +    wideUserName = string_to_wide(username, errp);
> +    if (!wideUserName)
> +    {
> +        goto error;
> +    }
> +
> +    // allocate data
> +    PWindowsUserInfo uData = g_malloc(sizeof(WindowsUserInfo));
> +
> +    // Set pointer so it can be cleaned up by the calle, even upon error.
> +    *userInfo = uData;
> +
> +    // Find the information
> +    NET_API_STATUS result = NetUserGetInfo(NULL, wideUserName, infoLevel, (LPBYTE *)&uBuf);
> +    if (result != NERR_Success)
> +    {
> +        // Give a friendlier error message if the user was not found.
> +        if (result == NERR_UserNotFound)
> +        {
> +            error_setg(errp, "User %s was not found", username);
> +            goto error;
> +        }
> +
> +        error_setg(errp, "Received unexpected error when asking for user info: Error Code %lu", result);
> +        goto error;
> +    }
> +
> +    // Get information from the buffer returned by NetUserGetInfo.
> +    uData->username = g_strdup(username);
> +    uData->isAdmin = uBuf->usri4_priv == USER_PRIV_ADMIN;
> +    PSID psid = uBuf->usri4_user_sid;
> +
> +    char *sidStr = NULL;
> +
> +    // We store the string representation of the SID not SID structure in memory. Callees wanting
> +    // to use the SID structure should call ConvertStringSidToSID.
> +    if (!ConvertSidToStringSid(psid, &sidStr))
> +    {
> +        error_setg_win32(errp, GetLastError(), "failed to get SID string for user %s", username);
> +        goto error;
> +    }
> +
> +    // Store the SSID
> +    uData->SSID = sidStr;
> +
> +    // Get the SSH folder for the user.
> +    char *sshFolder = get_ssh_folder(username, uData->isAdmin, errp);
> +    if (sshFolder == NULL)
> +    {
> +        goto error;
> +    }
> +
> +    // Get the authorized key file path
> +    const char *authorizedKeyFile = uData->isAdmin ? AUTHORIZED_KEY_FILE_ADMIN : AUTHORIZED_KEY_FILE;
> +    char *authorizedKeyPath = g_build_filename(sshFolder, authorizedKeyFile, NULL);
> +
> +    uData->sshDirectory = sshFolder;
> +    uData->authorizedKeyFile = authorizedKeyPath;
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
> +GuestAuthorizedKeys *qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
> +{
> +    GuestAuthorizedKeys *keys = NULL;
> +    g_auto(GStrv) authKeys = NULL;
> +    g_autoptr(GuestAuthorizedKeys) ret = NULL;
> +    g_auto(PWindowsUserInfo) userInfo = NULL;
> +
> +    // Gets user information
> +    if (!get_user_info(&userInfo, username, errp))
> +    {
> +        return NULL;
> +    }
> +
> +    // Reads authekys for the user
> +    authKeys = read_authkeys(userInfo->authorizedKeyFile, errp);
> +    if (authKeys == NULL)
> +    {
> +        return NULL;
> +    }
> +
> +    // Set the GuestAuthorizedKey struct with keys from the file
> +    ret = g_new0(GuestAuthorizedKeys, 1);
> +    for (int i = 0; authKeys[i] != NULL; i++)
> +    {
> +        g_strstrip(authKeys[i]);
> +        if (!authKeys[i][0] || authKeys[i][0] == '#')
> +        {
> +            continue;
> +        }
> +
> +        QAPI_LIST_PREPEND(ret->keys, g_strdup(authKeys[i]));
> +    }
> +
> +    // Steal the pointer because it is up for the callee to deallocate the memory.
> +    keys = g_steal_pointer(&ret);
> +    return keys;
> +}
> +
> +// Adds an ssh key for a user.
> +// parameters:
> +// username -> User to add the SSH key to
> +// strList -> Array of keys to add to the list
> +// has_reset -> Whether the keys have been reset
> +// reset -> Boolean to reset the keys (If this is set the existing list will be cleared) and the other key reset.
> +// errp -> Pointer to an error structure that will get returned over QMP if anything goes wrong.
> +void qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
> +                                       bool has_reset, bool reset,
> +                                       Error **errp)
> +{
> +    g_auto(PWindowsUserInfo) userInfo = NULL;
> +    g_auto(GStrv) authkeys = NULL;
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
> +    reset = has_reset && reset;
> +    if (!reset)
> +    {
> +        // If we are not resetting the keys, read the existing keys into memory
> +        authkeys = read_authkeys(userInfo->authorizedKeyFile, NULL);
> +    }
> +
> +    // Check that the SSH key directory exists for the user.
> +    if (!g_file_test(userInfo->sshDirectory, G_FILE_TEST_IS_DIR))
> +    {
> +        BOOL success = create_ssh_directory(userInfo, errp);
> +        if (!success)
> +        {
> +            return;
> +        }
> +    }
> +
> +    // Reallocates the buffer to fit the new keys.
> +    nauthkeys = authkeys ? g_strv_length(authkeys) : 0;
> +    authkeys = g_realloc_n(authkeys, nauthkeys + nkeys + 1, sizeof(char *));
> +
> +    // zero out the memory for the reallocated buffer
> +    memset(authkeys + nauthkeys, 0, (nkeys + 1) * sizeof(char *));
> +
> +    // Adds the keys
> +    for (k = keys; k != NULL; k = k->next)
> +    {
> +        // Check that the key doesn't already exist
> +        if (g_strv_contains((const gchar *const *)authkeys, k->value))
> +        {
> +            continue;
> +        }
> +
> +        authkeys[nauthkeys++] = g_strdup(k->value);
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
> +void qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
> +                                          Error **errp)
> +{
> +    g_auto(PWindowsUserInfo) userInfo = NULL;
> +    g_autofree struct passwd *p = NULL;
> +    g_autofree GStrv new_keys = NULL; /* do not own the strings */
> +    g_auto(GStrv) authkeys = NULL;
> +    GStrv a;
> +    size_t nkeys = 0;
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
> +    authkeys = read_authkeys(userInfo->authorizedKeyFile, errp);
> +    if (authkeys == NULL)
> +    {
> +        return;
> +    }
> +
> +    // Create a new buffer to hold the keys
> +    new_keys = g_new0(char *, g_strv_length(authkeys) + 1);
> +    for (a = authkeys; *a != NULL; a++)
> +    {
> +        strList *k;
> +
> +        // Filters out keys that are equal to ones the user specified.
> +        for (k = keys; k != NULL; k = k->next)
> +        {
> +            if (g_str_equal(k->value, *a))
> +            {
> +                break;
> +            }
> +        }
> +
> +        if (k != NULL)
> +        {
> +            continue;
> +        }
> +
> +        new_keys[nkeys++] = *a;
> +    }
> +
> +    // Write the new authkeys to the file.
> +    write_authkeys(userInfo, new_keys, errp);
> +}
> \ No newline at end of file

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


