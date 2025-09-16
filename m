Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25BEECAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYUO-0003v9-TJ; Tue, 16 Sep 2025 12:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYUM-0003uC-LB
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:25:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uyYUI-0002xb-IK
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758039901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=73ayhyy74X/LsrJVUwGjgLG6sGCLue/v19/4vtUlVHY=;
 b=Cls6Op8v2wUI7Z+y6FOd+fH/eJnjPpjBV+QH/YWntkesi3h+AUinMREa/+tZOmT+roIck7
 9+aU4vgOnxWyxuusWAs/GqaIGfzgxeDRiNfVDvP7SaNfuYVB2xmvxQAejOskkfcGiIkNoe
 MPbgnbAz87kGpCZeP2V+hbO0cVooLiU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-XSo2YtOfNQa9j5I3xMwiiw-1; Tue,
 16 Sep 2025 12:24:59 -0400
X-MC-Unique: XSo2YtOfNQa9j5I3xMwiiw-1
X-Mimecast-MFC-AGG-ID: XSo2YtOfNQa9j5I3xMwiiw_1758039898
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB4D5180057A; Tue, 16 Sep 2025 16:24:58 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.221])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8A2919560BA; Tue, 16 Sep 2025 16:24:55 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Michael Roth <michael.roth@amd.com>,
 John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 14/19] python: synchronize qemu.qmp documentation
Date: Tue, 16 Sep 2025 12:23:59 -0400
Message-ID: <20250916162404.9195-15-jsnow@redhat.com>
In-Reply-To: <20250916162404.9195-1-jsnow@redhat.com>
References: <20250916162404.9195-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.009,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch collects comments and documentation changes from many commits
in the python-qemu-qmp repository; bringing the qemu.git copy in
bit-identical alignment with the standalone library *except* for several
copyright messages that reference the "LICENSE" file which is, for QEMU,
named "COPYING" instead and are therefore left unchanged.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 python/qemu/qmp/__init__.py   |   3 +-
 python/qemu/qmp/events.py     |  35 +++++++---
 python/qemu/qmp/legacy.py     |   4 +-
 python/qemu/qmp/message.py    |  10 ++-
 python/qemu/qmp/models.py     |   8 +--
 python/qemu/qmp/protocol.py   |  37 ++++++----
 python/qemu/qmp/qmp_client.py | 117 +++++++++++++++++++++++--------
 python/qemu/qmp/qmp_shell.py  | 128 ++++++++++++++++++++++++++--------
 python/qemu/qmp/util.py       |   9 ++-
 9 files changed, 264 insertions(+), 87 deletions(-)

diff --git a/python/qemu/qmp/__init__.py b/python/qemu/qmp/__init__.py
index 69190d057a5..058139dc3ca 100644
--- a/python/qemu/qmp/__init__.py
+++ b/python/qemu/qmp/__init__.py
@@ -39,7 +39,8 @@
 logging.getLogger('qemu.qmp').addHandler(logging.NullHandler())
 
 
-# The order of these fields impact the Sphinx documentation order.
+# IMPORTANT: When modifying this list, update the Sphinx overview docs.
+# Anything visible in the qemu.qmp namespace should be on the overview page.
 __all__ = (
     # Classes, most to least important
     'QMPClient',
diff --git a/python/qemu/qmp/events.py b/python/qemu/qmp/events.py
index 66583496192..cfb5f0ac621 100644
--- a/python/qemu/qmp/events.py
+++ b/python/qemu/qmp/events.py
@@ -12,7 +12,14 @@
 ----------------------
 
 In all of the following examples, we assume that we have a `QMPClient`
-instantiated named ``qmp`` that is already connected.
+instantiated named ``qmp`` that is already connected. For example:
+
+.. code:: python
+
+   from qemu.qmp import QMPClient
+
+   qmp = QMPClient('example-vm')
+   await qmp.connect('127.0.0.1', 1234)
 
 
 `listener()` context blocks with one name
@@ -87,7 +94,9 @@
            event = listener.get()
            print(f"Event arrived: {event['event']}")
 
-This event stream will never end, so these blocks will never terminate.
+This event stream will never end, so these blocks will never
+terminate. Even if the QMP connection errors out prematurely, this
+listener will go silent without raising an error.
 
 
 Using asyncio.Task to concurrently retrieve events
@@ -227,16 +236,20 @@ async def print_events(listener):
 .. code:: python
 
    await qmp.execute('stop')
-   qmp.events.clear()
+   discarded = qmp.events.clear()
    await qmp.execute('cont')
    event = await qmp.events.get()
    assert event['event'] == 'RESUME'
+   assert discarded[0]['event'] == 'STOP'
 
 `EventListener` objects are FIFO queues. If events are not consumed,
 they will remain in the queue until they are witnessed or discarded via
 `clear()`. FIFO queues will be drained automatically upon leaving a
 context block, or when calling `remove_listener()`.
 
+Any events removed from the queue in this fashion will be returned by
+the clear call.
+
 
 Accessing listener history
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -350,6 +363,12 @@ def filter(event: Message) -> bool:
                break
 
 
+Note that in the above example, we explicitly wait on jobA to conclude
+first, and then wait for jobB to do the same. All we have guaranteed is
+that the code that waits for jobA will not accidentally consume the
+event intended for the jobB waiter.
+
+
 Extending the `EventListener` class
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
@@ -407,13 +426,13 @@ def accept(self, event) -> bool:
 These interfaces are not ones I am sure I will keep or otherwise modify
 heavily.
 
-qmp.listener()’s type signature
+qmp.listen()’s type signature
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-`listener()` does not return anything, because it was assumed the caller
+`listen()` does not return anything, because it was assumed the caller
 already had a handle to the listener. However, for
-``qmp.listener(EventListener())`` forms, the caller will not have saved
-a handle to the listener.
+``qmp.listen(EventListener())`` forms, the caller will not have saved a
+handle to the listener.
 
 Because this function can accept *many* listeners, I found it hard to
 accurately type in a way where it could be used in both “one” or “many”
@@ -633,7 +652,7 @@ class Events:
     def __init__(self) -> None:
         self._listeners: List[EventListener] = []
 
-        #: Default, all-events `EventListener`.
+        #: Default, all-events `EventListener`. See `qmp.events` for more info.
         self.events: EventListener = EventListener()
         self.register_listener(self.events)
 
diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index e46695ae2c8..060ed0eb9d4 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -293,8 +293,8 @@ def settimeout(self, timeout: Optional[float]) -> None:
         """
         Set the timeout for QMP RPC execution.
 
-        This timeout affects the `cmd`, `cmd_obj`, and `command` methods.
-        The `accept`, `pull_event` and `get_event` methods have their
+        This timeout affects the `cmd`, `cmd_obj`, and `cmd_raw` methods.
+        The `accept`, `pull_event` and `get_events` methods have their
         own configurable timeouts.
 
         :param timeout:
diff --git a/python/qemu/qmp/message.py b/python/qemu/qmp/message.py
index c2e9dd0dd54..dabb8ec360e 100644
--- a/python/qemu/qmp/message.py
+++ b/python/qemu/qmp/message.py
@@ -28,7 +28,8 @@ class Message(MutableMapping[str, object]):
     be instantiated from either another mapping (like a `dict`), or from
     raw `bytes` that still need to be deserialized.
 
-    Once instantiated, it may be treated like any other MutableMapping::
+    Once instantiated, it may be treated like any other
+    :py:obj:`~collections.abc.MutableMapping`::
 
         >>> msg = Message(b'{"hello": "world"}')
         >>> assert msg['hello'] == 'world'
@@ -50,12 +51,19 @@ class Message(MutableMapping[str, object]):
        >>> dict(msg)
        {'hello': 'world'}
 
+    Or pretty-printed::
+
+       >>> print(str(msg))
+       {
+         "hello": "world"
+       }
 
     :param value: Initial value, if any.
     :param eager:
         When `True`, attempt to serialize or deserialize the initial value
         immediately, so that conversion exceptions are raised during
         the call to ``__init__()``.
+
     """
     # pylint: disable=too-many-ancestors
 
diff --git a/python/qemu/qmp/models.py b/python/qemu/qmp/models.py
index da52848d5a7..7e0d0baf038 100644
--- a/python/qemu/qmp/models.py
+++ b/python/qemu/qmp/models.py
@@ -54,7 +54,7 @@ def __repr__(self) -> str:
 
 class Greeting(Model):
     """
-    Defined in qmp-spec.rst, section "Server Greeting".
+    Defined in `interop/qmp-spec`, "Server Greeting" section.
 
     :param raw: The raw Greeting object.
     :raise KeyError: If any required fields are absent.
@@ -82,7 +82,7 @@ def _asdict(self) -> Dict[str, object]:
 
 class QMPGreeting(Model):
     """
-    Defined in qmp-spec.rst, section "Server Greeting".
+    Defined in `interop/qmp-spec`, "Server Greeting" section.
 
     :param raw: The raw QMPGreeting object.
     :raise KeyError: If any required fields are absent.
@@ -104,7 +104,7 @@ def __init__(self, raw: Mapping[str, Any]):
 
 class ErrorResponse(Model):
     """
-    Defined in qmp-spec.rst, section "Error".
+    Defined in `interop/qmp-spec`, "Error" section.
 
     :param raw: The raw ErrorResponse object.
     :raise KeyError: If any required fields are absent.
@@ -126,7 +126,7 @@ def __init__(self, raw: Mapping[str, Any]):
 
 class ErrorInfo(Model):
     """
-    Defined in qmp-spec.rst, section "Error".
+    Defined in `interop/qmp-spec`, "Error" section.
 
     :param raw: The raw ErrorInfo object.
     :raise KeyError: If any required fields are absent.
diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 4d8a39f014b..219d092a792 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -79,6 +79,12 @@ class ConnectError(QMPError):
     This Exception always wraps a "root cause" exception that can be
     interrogated for additional information.
 
+    For example, when connecting to a non-existent socket::
+
+        await qmp.connect('not_found.sock')
+        # ConnectError: Failed to establish connection:
+        #               [Errno 2] No such file or directory
+
     :param error_message: Human-readable string describing the error.
     :param exc: The root-cause exception.
     """
@@ -102,8 +108,8 @@ class StateError(QMPError):
     An API command (connect, execute, etc) was issued at an inappropriate time.
 
     This error is raised when a command like
-    :py:meth:`~AsyncProtocol.connect()` is issued at an inappropriate
-    time.
+    :py:meth:`~AsyncProtocol.connect()` is called when the client is
+    already connected.
 
     :param error_message: Human-readable string describing the state violation.
     :param state: The actual `Runstate` seen at the time of the violation.
@@ -298,7 +304,7 @@ def runstate(self) -> Runstate:
     @upper_half
     async def runstate_changed(self) -> Runstate:
         """
-        Wait for the `runstate` to change, then return that runstate.
+        Wait for the `runstate` to change, then return that `Runstate`.
         """
         await self._runstate_event.wait()
         return self.runstate
@@ -312,9 +318,9 @@ async def start_server_and_accept(
         """
         Accept a connection and begin processing message queues.
 
-        If this call fails, `runstate` is guaranteed to be set back to `IDLE`.
-        This method is precisely equivalent to calling `start_server()`
-        followed by `accept()`.
+        If this call fails, `runstate` is guaranteed to be set back to
+        `IDLE`.  This method is precisely equivalent to calling
+        `start_server()` followed by :py:meth:`~AsyncProtocol.accept()`.
 
         :param address:
             Address to listen on; UNIX socket path or TCP address/port.
@@ -327,7 +333,8 @@ async def start_server_and_accept(
             This exception will wrap a more concrete one. In most cases,
             the wrapped exception will be `OSError` or `EOFError`. If a
             protocol-level failure occurs while establishing a new
-            session, the wrapped error may also be an `QMPError`.
+            session, the wrapped error may also be a `QMPError`.
+
         """
         await self.start_server(address, ssl)
         await self.accept()
@@ -343,8 +350,8 @@ async def start_server(self, address: SocketAddrT,
         This method starts listening for an incoming connection, but
         does not block waiting for a peer. This call will return
         immediately after binding and listening on a socket. A later
-        call to `accept()` must be made in order to finalize the
-        incoming connection.
+        call to :py:meth:`~AsyncProtocol.accept()` must be made in order
+        to finalize the incoming connection.
 
         :param address:
             Address to listen on; UNIX socket path or TCP address/port.
@@ -367,10 +374,12 @@ async def accept(self) -> None:
         """
         Accept an incoming connection and begin processing message queues.
 
-        If this call fails, `runstate` is guaranteed to be set back to `IDLE`.
+        Used after a previous call to `start_server()` to accept an
+        incoming connection. If this call fails, `runstate` is
+        guaranteed to be set back to `IDLE`.
 
         :raise StateError: When the `Runstate` is not `CONNECTING`.
-        :raise QMPError: When `start_server()` was not called yet.
+        :raise QMPError: When `start_server()` was not called first.
         :raise ConnectError:
             When a connection or session cannot be established.
 
@@ -423,7 +432,11 @@ async def disconnect(self) -> None:
         If there was an exception that caused the reader/writers to
         terminate prematurely, it will be raised here.
 
-        :raise Exception: When the reader or writer terminate unexpectedly.
+        :raise Exception:
+            When the reader or writer terminate unexpectedly. You can
+            expect to see `EOFError` if the server hangs up, or
+            `OSError` for connection-related issues. If there was a QMP
+            protocol-level problem, `ProtocolError` will be seen.
         """
         self.logger.debug("disconnect() called.")
         self._schedule_disconnect()
diff --git a/python/qemu/qmp/qmp_client.py b/python/qemu/qmp/qmp_client.py
index d826331b6d5..8beccfe29d3 100644
--- a/python/qemu/qmp/qmp_client.py
+++ b/python/qemu/qmp/qmp_client.py
@@ -70,6 +70,17 @@ class ExecuteError(QMPError):
     """
     Exception raised by `QMPClient.execute()` on RPC failure.
 
+    This exception is raised when the server received, interpreted, and
+    replied to a command successfully; but the command itself returned a
+    failure status.
+
+    For example::
+
+        await qmp.execute('block-dirty-bitmap-add',
+                          {'node': 'foo', 'name': 'my_bitmap'})
+        # qemu.qmp.qmp_client.ExecuteError:
+        #     Cannot find device='foo' nor node-name='foo'
+
     :param error_response: The RPC error response object.
     :param sent: The sent RPC message that caused the failure.
     :param received: The raw RPC error reply received.
@@ -99,9 +110,22 @@ class ExecInterruptedError(QMPError):
 
     This error is raised when an `execute()` statement could not be
     completed.  This can occur because the connection itself was
-    terminated before a reply was received.
+    terminated before a reply was received. The true cause of the
+    interruption will be available via `disconnect()`.
 
-    The true cause of the interruption will be available via `disconnect()`.
+    The QMP protocol does not make it possible to know if a command
+    succeeded or failed after such an event; the client will need to
+    query the server to determine the state of the server on a
+    case-by-case basis.
+
+    For example, ECONNRESET might look like this::
+
+        try:
+            await qmp.execute('query-block')
+            # ExecInterruptedError: Disconnected
+        except ExecInterruptedError:
+            await qmp.disconnect()
+            # ConnectionResetError: [Errno 104] Connection reset by peer
     """
 
 
@@ -162,13 +186,14 @@ def __init__(self, error_message: str, msg: Message, sent: Message):
 
 
 class QMPClient(AsyncProtocol[Message], Events):
-    """
-    Implements a QMP client connection.
+    """Implements a QMP client connection.
 
-    QMP can be used to establish a connection as either the transport
-    client or server, though this class always acts as the QMP client.
+    `QMPClient` can be used to either connect or listen to a QMP server,
+    but always acts as the QMP client.
 
-    :param name: Optional nickname for the connection, used for logging.
+    :param name:
+        Optional nickname for the connection, used to differentiate
+        instances when logging.
 
     :param readbuflen:
         The maximum buffer length for reads and writes to and from the QMP
@@ -178,14 +203,21 @@ class QMPClient(AsyncProtocol[Message], Events):
 
     Basic script-style usage looks like this::
 
-      qmp = QMPClient('my_virtual_machine_name')
-      await qmp.connect(('127.0.0.1', 1234))
-      ...
-      res = await qmp.execute('block-query')
-      ...
-      await qmp.disconnect()
+      import asyncio
+      from qemu.qmp import QMPClient
 
-    Basic async client-style usage looks like this::
+      async def main():
+          qmp = QMPClient('my_virtual_machine_name')
+          await qmp.connect(('127.0.0.1', 1234))
+          ...
+          res = await qmp.execute('query-block')
+          ...
+          await qmp.disconnect()
+
+      asyncio.run(main())
+
+    A more advanced example that starts to take advantage of asyncio
+    might look like this::
 
       class Client:
           def __init__(self, name: str):
@@ -205,6 +237,7 @@ async def run(self, address='/tmp/qemu.socket'):
               await self.disconnect()
 
     See `qmp.events` for more detail on event handling patterns.
+
     """
     #: Logger object used for debugging messages.
     logger = logging.getLogger(__name__)
@@ -224,10 +257,12 @@ def __init__(
         Events.__init__(self)
 
         #: Whether or not to await a greeting after establishing a connection.
+        #: Defaults to True; QGA servers expect this to be False.
         self.await_greeting: bool = True
 
-        #: Whether or not to perform capabilities negotiation upon connection.
-        #: Implies `await_greeting`.
+        #: Whether or not to perform capabilities negotiation upon
+        #: connection. Implies `await_greeting`. Defaults to True; QGA
+        #: servers expect this to be False.
         self.negotiate: bool = True
 
         # Cached Greeting, if one was awaited.
@@ -244,7 +279,13 @@ def __init__(
 
     @property
     def greeting(self) -> Optional[Greeting]:
-        """The `Greeting` from the QMP server, if any."""
+        """
+        The `Greeting` from the QMP server, if any.
+
+        Defaults to ``None``, and will be set after a greeting is
+        received during the connection process. It is reset at the start
+        of each connection attempt.
+        """
         return self._greeting
 
     @upper_half
@@ -385,7 +426,7 @@ async def _on_message(self, msg: Message) -> None:
             # This is very likely a server parsing error.
             # It doesn't inherently belong to any pending execution.
             # Instead of performing clever recovery, just terminate.
-            # See "NOTE" in qmp-spec.rst, section "Error".
+            # See "NOTE" in interop/qmp-spec, "Error" section.
             raise ServerParseError(
                 ("Server sent an error response without an ID, "
                  "but there are no ID-less executions pending. "
@@ -393,7 +434,7 @@ async def _on_message(self, msg: Message) -> None:
                 msg
             )
 
-        # qmp-spec.rst, section "Commands Responses":
+        # qmp-spec.rst, "Commands Responses" section:
         # 'Clients should drop all the responses
         # that have an unknown "id" field.'
         self.logger.log(
@@ -566,7 +607,7 @@ async def _raw(
     @require(Runstate.RUNNING)
     async def execute_msg(self, msg: Message) -> object:
         """
-        Execute a QMP command and return its value.
+        Execute a QMP command on the server and return its value.
 
         :param msg: The QMP `Message` to execute.
 
@@ -578,7 +619,9 @@ async def execute_msg(self, msg: Message) -> object:
             If the QMP `Message` does not have either the 'execute' or
             'exec-oob' fields set.
         :raise ExecuteError: When the server returns an error response.
-        :raise ExecInterruptedError: if the connection was terminated early.
+        :raise ExecInterruptedError:
+            If the connection was disrupted before
+            receiving a reply from the server.
         """
         if not ('execute' in msg or 'exec-oob' in msg):
             raise ValueError("Requires 'execute' or 'exec-oob' message")
@@ -617,9 +660,11 @@ def make_execute_msg(cls, cmd: str,
 
         :param cmd: QMP command name.
         :param arguments: Arguments (if any). Must be JSON-serializable.
-        :param oob: If `True`, execute "out of band".
+        :param oob:
+            If `True`, execute "out of band". See `interop/qmp-spec`
+            section "Out-of-band execution".
 
-        :return: An executable QMP `Message`.
+        :return: A QMP `Message` that can be executed with `execute_msg()`.
         """
         msg = Message({'exec-oob' if oob else 'execute': cmd})
         if arguments is not None:
@@ -631,18 +676,22 @@ async def execute(self, cmd: str,
                       arguments: Optional[Mapping[str, object]] = None,
                       oob: bool = False) -> object:
         """
-        Execute a QMP command and return its value.
+        Execute a QMP command on the server and return its value.
 
         :param cmd: QMP command name.
         :param arguments: Arguments (if any). Must be JSON-serializable.
-        :param oob: If `True`, execute "out of band".
+        :param oob:
+            If `True`, execute "out of band". See `interop/qmp-spec`
+            section "Out-of-band execution".
 
         :return:
             The command execution return value from the server. The type of
             object returned depends on the command that was issued,
             though most in QEMU return a `dict`.
         :raise ExecuteError: When the server returns an error response.
-        :raise ExecInterruptedError: if the connection was terminated early.
+        :raise ExecInterruptedError:
+            If the connection was disrupted before
+            receiving a reply from the server.
         """
         msg = self.make_execute_msg(cmd, arguments, oob=oob)
         return await self.execute_msg(msg)
@@ -650,8 +699,20 @@ async def execute(self, cmd: str,
     @upper_half
     @require(Runstate.RUNNING)
     def send_fd_scm(self, fd: int) -> None:
-        """
-        Send a file descriptor to the remote via SCM_RIGHTS.
+        """Send a file descriptor to the remote via SCM_RIGHTS.
+
+        This method does not close the file descriptor.
+
+        :param fd: The file descriptor to send to QEMU.
+
+        This is an advanced feature of QEMU where file descriptors can
+        be passed from client to server. This is usually used as a
+        security measure to isolate the QEMU process from being able to
+        open its own files. See the QMP commands ``getfd`` and
+        ``add-fd`` for more information.
+
+        See `socket.socket.sendmsg` for more information on the Python
+        implementation for sending file descriptors over a UNIX socket.
         """
         assert self._writer is not None
         sock = self._writer.transport.get_extra_info('socket')
diff --git a/python/qemu/qmp/qmp_shell.py b/python/qemu/qmp/qmp_shell.py
index c923ff09e1f..f8188005685 100644
--- a/python/qemu/qmp/qmp_shell.py
+++ b/python/qemu/qmp/qmp_shell.py
@@ -10,9 +10,15 @@
 #
 
 """
-Low-level QEMU shell on top of QMP.
+qmp-shell - An interactive QEMU shell powered by QMP
 
-usage: qmp-shell [-h] [-H] [-N] [-v] [-p] qmp_server
+qmp-shell offers a simple shell with a convenient shorthand syntax as an
+alternative to typing JSON by hand. This syntax is not standardized and
+is not meant to be used as a scriptable interface. This shorthand *may*
+change incompatibly in the future, and it is strongly encouraged to use
+the QMP library to provide API-stable scripting when needed.
+
+usage: qmp-shell [-h] [-H] [-v] [-p] [-l LOGFILE] [-N] qmp_server
 
 positional arguments:
   qmp_server            < UNIX socket path | TCP address:port >
@@ -20,41 +26,52 @@
 optional arguments:
   -h, --help            show this help message and exit
   -H, --hmp             Use HMP interface
-  -N, --skip-negotiation
-                        Skip negotiate (for qemu-ga)
   -v, --verbose         Verbose (echo commands sent and received)
   -p, --pretty          Pretty-print JSON
+  -l LOGFILE, --logfile LOGFILE
+                        Save log of all QMP messages to PATH
+  -N, --skip-negotiation
+                        Skip negotiate (for qemu-ga)
 
+Usage
+-----
 
-Start QEMU with:
+First, start QEMU with::
 
-# qemu [...] -qmp unix:./qmp-sock,server
+    > qemu [...] -qmp unix:./qmp-sock,server=on[,wait=off]
 
-Run the shell:
+Then run the shell, passing the address of the socket::
 
-$ qmp-shell ./qmp-sock
+    > qmp-shell ./qmp-sock
 
-Commands have the following format:
+Syntax
+------
 
-   < command-name > [ arg-name1=arg1 ] ... [ arg-nameN=argN ]
+Commands have the following format::
 
-For example:
+    < command-name > [ arg-name1=arg1 ] ... [ arg-nameN=argN ]
 
-(QEMU) device_add driver=e1000 id=net1
-{'return': {}}
-(QEMU)
+For example, to add a network device::
 
-key=value pairs also support Python or JSON object literal subset notations,
-without spaces. Dictionaries/objects {} are supported as are arrays [].
+    (QEMU) device_add driver=e1000 id=net1
+    {'return': {}}
+    (QEMU)
 
-   example-command arg-name1={'key':'value','obj'={'prop':"value"}}
+key=value pairs support either Python or JSON object literal notations,
+**without spaces**. Dictionaries/objects ``{}`` are supported, as are
+arrays ``[]``::
 
-Both JSON and Python formatting should work, including both styles of
-string literal quotes. Both paradigms of literal values should work,
-including null/true/false for JSON and None/True/False for Python.
+    example-command arg-name1={'key':'value','obj'={'prop':"value"}}
 
+Either JSON or Python formatting for compound values works, including
+both styles of string literal quotes (either single or double
+quotes). Both paradigms of literal values are accepted, including
+``null/true/false`` for JSON and ``None/True/False`` for Python.
 
-Transactions have the following multi-line format:
+Transactions
+------------
+
+Transactions have the following multi-line format::
 
    transaction(
    action-name1 [ arg-name1=arg1 ] ... [arg-nameN=argN ]
@@ -62,11 +79,11 @@
    action-nameN [ arg-name1=arg1 ] ... [arg-nameN=argN ]
    )
 
-One line transactions are also supported:
+One line transactions are also supported::
 
    transaction( action-name1 ... )
 
-For example:
+For example::
 
     (QEMU) transaction(
     TRANS> block-dirty-bitmap-add node=drive0 name=bitmap1
@@ -75,9 +92,35 @@
     {"return": {}}
     (QEMU)
 
-Use the -v and -p options to activate the verbose and pretty-print options,
-which will echo back the properly formatted JSON-compliant QMP that is being
-sent to QEMU, which is useful for debugging and documentation generation.
+Commands
+--------
+
+Autocomplete of command names using <tab> is supported. Pressing <tab>
+at a blank CLI prompt will show you a list of all available commands
+that the connected QEMU instance supports.
+
+For documentation on QMP commands and their arguments, please see
+`qmp ref`.
+
+Events
+------
+
+qmp-shell will display events received from the server, but this version
+does not do so asynchronously. To check for new events from the server,
+press <enter> on a blank line::
+
+    (QEMU) ⏎
+    {'timestamp': {'seconds': 1660071944, 'microseconds': 184667},
+     'event': 'STOP'}
+
+Display options
+---------------
+
+Use the -v and -p options to activate the verbose and pretty-print
+options, which will echo back the properly formatted JSON-compliant QMP
+that is being sent to QEMU. This is useful for debugging to see the
+wire-level QMP data being exchanged, and generating output for use in
+writing documentation for QEMU.
 """
 
 import argparse
@@ -525,6 +568,8 @@ def common_parser() -> argparse.ArgumentParser:
                         help='Pretty-print JSON')
     parser.add_argument('-l', '--logfile',
                         help='Save log of all QMP messages to PATH')
+    # NOTE: When changing arguments, update both this module docstring
+    # and the manpage synopsis in docs/man/qmp_shell.rst.
     return parser
 
 
@@ -567,8 +612,35 @@ def main() -> None:
 
 def main_wrap() -> None:
     """
-    qmp-shell-wrap entry point: parse command line arguments and
-    start the REPL.
+    qmp-shell-wrap - QEMU + qmp-shell launcher utility
+
+    Launch QEMU and connect to it with `qmp-shell` in a single command.
+    CLI arguments will be forwarded to qemu, with additional arguments
+    added to allow `qmp-shell` to then connect to the recently launched
+    QEMU instance.
+
+    usage: qmp-shell-wrap [-h] [-H] [-v] [-p] [-l LOGFILE] ...
+
+    positional arguments:
+      command               QEMU command line to invoke
+
+    optional arguments:
+      -h, --help            show this help message and exit
+      -H, --hmp             Use HMP interface
+      -v, --verbose         Verbose (echo commands sent and received)
+      -p, --pretty          Pretty-print JSON
+      -l LOGFILE, --logfile LOGFILE
+                            Save log of all QMP messages to PATH
+
+    Usage
+    -----
+
+    Prepend "qmp-shell-wrap" to your usual QEMU command line::
+
+        > qmp-shell-wrap qemu-system-x86_64 -M q35 -m 4096 -display none
+        Welcome to the QMP low-level shell!
+        Connected
+        (QEMU)
     """
     parser = common_parser()
     parser.add_argument('command', nargs=argparse.REMAINDER,
diff --git a/python/qemu/qmp/util.py b/python/qemu/qmp/util.py
index 47ec39a8b5e..a8229e55245 100644
--- a/python/qemu/qmp/util.py
+++ b/python/qemu/qmp/util.py
@@ -49,7 +49,7 @@ def get_or_create_event_loop() -> asyncio.AbstractEventLoop:
 
 async def flush(writer: asyncio.StreamWriter) -> None:
     """
-    Utility function to ensure a StreamWriter is *fully* drained.
+    Utility function to ensure an `asyncio.StreamWriter` is *fully* drained.
 
     `asyncio.StreamWriter.drain` only promises we will return to below
     the "high-water mark". This function ensures we flush the entire
@@ -89,7 +89,7 @@ def bottom_half(func: T) -> T:
 
     These methods do not, in general, have the ability to directly
     report information to a caller’s context and will usually be
-    collected as a Task result instead.
+    collected as an `asyncio.Task` result instead.
 
     They must not call upper-half functions directly.
     """
@@ -105,8 +105,11 @@ def exception_summary(exc: BaseException) -> str:
     """
     Return a summary string of an arbitrary exception.
 
-    It will be of the form "ExceptionType: Error Message", if the error
+    It will be of the form "ExceptionType: Error Message" if the error
     string is non-empty, and just "ExceptionType" otherwise.
+
+    This code is based on CPython's implementation of
+    `traceback.TracebackException.format_exception_only`.
     """
     name = type(exc).__qualname__
     smod = type(exc).__module__
-- 
2.51.0


